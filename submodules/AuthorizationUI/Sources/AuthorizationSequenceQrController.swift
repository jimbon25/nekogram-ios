import Foundation
import UIKit
import Display
import AsyncDisplayKit
import TelegramCore
import SwiftSignalKit
import TelegramPresentationData
import QrCode
import AccountContext

final class AuthorizationSequenceQrControllerNode: ASDisplayNode {
    private let theme: PresentationTheme
    private let strings: PresentationStrings
    
    private let titleNode: ASTextNode
    private let noticeNode: ASTextNode
    private let qrCardNode: ASDisplayNode
    private let qrImageNode: ASImageNode
    private let activityIndicator: UIActivityIndicatorView
    
    init(theme: PresentationTheme, strings: PresentationStrings) {
        self.theme = theme
        self.strings = strings
        
        self.titleNode = ASTextNode()
        self.titleNode.isUserInteractionEnabled = false
        self.titleNode.displaysAsynchronously = false
        self.titleNode.attributedText = NSAttributedString(
            string: "Log in by QR Code",
            font: Font.bold(28.0),
            textColor: self.theme.list.itemPrimaryTextColor,
            paragraphAlignment: .center
        )
        
        self.noticeNode = ASTextNode()
        self.noticeNode.isUserInteractionEnabled = false
        self.noticeNode.displaysAsynchronously = false
        
        let instructions = "Scan from Telegram on your other device:\n1. Open Telegram Settings > Devices\n2. Tap 'Link Desktop Device'\n3. Point your camera at this screen"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4.0
        
        self.noticeNode.attributedText = NSAttributedString(
            string: instructions,
            attributes: [
                .font: Font.regular(15.0),
                .foregroundColor: self.theme.list.itemSecondaryTextColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        self.qrCardNode = ASDisplayNode()
        self.qrCardNode.backgroundColor = .white
        self.qrCardNode.cornerRadius = 20.0
        self.qrCardNode.clipsToBounds = true
        
        self.qrImageNode = ASImageNode()
        self.qrImageNode.displaysAsynchronously = false
        self.qrImageNode.contentMode = .scaleAspectFit
        
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        self.activityIndicator.color = .darkGray
        self.activityIndicator.startAnimating()
        
        super.init()
        
        self.setViewBlock({
            return UITracingLayerView()
        })
        
        self.backgroundColor = self.theme.list.plainBackgroundColor
        
        self.addSubnode(self.titleNode)
        self.addSubnode(self.noticeNode)
        self.addSubnode(self.qrCardNode)
        self.qrCardNode.addSubnode(self.qrImageNode)
        self.qrCardNode.view.addSubview(self.activityIndicator)
    }
    
    func updateQrImage(_ image: UIImage?) {
        if let image = image {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.qrImageNode.image = image
        } else {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.qrImageNode.image = nil
        }
    }
    
    func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationBarHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        let topInset = navigationBarHeight + 20.0
        let maximumWidth = min(layout.size.width - 32.0, 360.0)
        
        let titleSize = self.titleNode.measure(CGSize(width: maximumWidth, height: CGFloat.greatestFiniteMagnitude))
        let noticeSize = self.noticeNode.measure(CGSize(width: maximumWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let cardSize: CGFloat = min(260.0, layout.size.width - 64.0)
        let qrSize: CGFloat = cardSize - 32.0
        
        let titleFrame = CGRect(origin: CGPoint(x: floorToScreenPixels((layout.size.width - titleSize.width) / 2.0), y: topInset), size: titleSize)
        transition.updateFrame(node: self.titleNode, frame: titleFrame)
        
        let noticeFrame = CGRect(origin: CGPoint(x: floorToScreenPixels((layout.size.width - noticeSize.width) / 2.0), y: titleFrame.maxY + 14.0), size: noticeSize)
        transition.updateFrame(node: self.noticeNode, frame: noticeFrame)
        
        let cardFrame = CGRect(origin: CGPoint(x: floorToScreenPixels((layout.size.width - cardSize) / 2.0), y: noticeFrame.maxY + 28.0), size: CGSize(width: cardSize, height: cardSize))
        transition.updateFrame(node: self.qrCardNode, frame: cardFrame)
        
        let qrFrame = CGRect(origin: CGPoint(x: 16.0, y: 16.0), size: CGSize(width: qrSize, height: qrSize))
        self.qrImageNode.frame = qrFrame
        
        self.activityIndicator.center = CGPoint(x: cardSize / 2.0, y: cardSize / 2.0)
    }
}

public final class AuthorizationSequenceQrController: ViewController {
    private var controllerNode: AuthorizationSequenceQrControllerNode {
        return self.displayNode as! AuthorizationSequenceQrControllerNode
    }
    
    private let sharedContext: SharedAccountContext
    private var account: UnauthorizedAccount
    private let presentationData: PresentationData
    public var accountUpdated: ((UnauthorizedAccount) -> Void)?
    
    private let exportTokenDisposable = MetaDisposable()
    private let tokenEventsDisposable = MetaDisposable()
    
    public init(sharedContext: SharedAccountContext, account: UnauthorizedAccount, presentationData: PresentationData) {
        self.sharedContext = sharedContext
        self.account = account
        self.presentationData = presentationData
        
        super.init(navigationBarPresentationData: NavigationBarPresentationData(theme: AuthorizationSequenceController.navigationBarTheme(presentationData.theme), strings: NavigationBarStrings(presentationStrings: presentationData.strings)))
        
        self.navigationPresentation = .modal
        self.supportedOrientations = ViewControllerSupportedOrientations(regularSize: .all, compactSize: .portrait)
        self.statusBar.statusBarStyle = presentationData.theme.intro.statusBarStyle.style
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: self.presentationData.strings.Common_Close, style: .plain, target: self, action: #selector(self.closePressed))
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.exportTokenDisposable.dispose()
        self.tokenEventsDisposable.dispose()
    }
    
    override public func loadDisplayNode() {
        self.displayNode = AuthorizationSequenceQrControllerNode(theme: self.presentationData.theme, strings: self.presentationData.strings)
        self.displayNodeDidLoad()
        
        self.tokenEventsDisposable.set((self.account.updateLoginTokenEvents
        |> deliverOnMainQueue).startStrict(next: { [weak self] _ in
            self?.refreshQrToken()
        }))
        
        self.refreshQrToken()
    }
    
    @objc private func closePressed() {
        self.dismiss()
    }
    
    private func refreshQrToken() {
        let account = self.account
        let sharedContext = self.sharedContext
        let tokenSignal = sharedContext.activeAccountContexts
        |> castError(ExportAuthTransferTokenError.self)
        |> take(1)
        |> mapToSignal { activeAccountsAndInfo -> Signal<ExportAuthTransferTokenResult, ExportAuthTransferTokenError> in
            let (_, activeAccounts, _) = activeAccountsAndInfo
            let activeProductionUserIds = activeAccounts.map({ $0.1.account }).filter({ !$0.testingEnvironment }).map({ $0.peerId.id })
            let activeTestingUserIds = activeAccounts.map({ $0.1.account }).filter({ $0.testingEnvironment }).map({ $0.peerId.id })
            
            return TelegramEngineUnauthorized(account: account).auth.exportAuthTransferToken(accountManager: sharedContext.accountManager, otherAccountUserIds: account.testingEnvironment ? activeTestingUserIds : activeProductionUserIds, syncContacts: true)
        }
        
        self.exportTokenDisposable.set((tokenSignal
        |> deliverOnMainQueue).startStrict(next: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case let .displayToken(token):
                var tokenString = token.value.base64EncodedString()
                tokenString = tokenString.replacingOccurrences(of: "+", with: "-")
                tokenString = tokenString.replacingOccurrences(of: "/", with: "_")
                let urlString = "tg://login?token=\(tokenString)"
                let _ = (qrCode(string: urlString, color: .black, backgroundColor: .white, icon: .none)
                |> deliverOnMainQueue).startStandalone(next: { [weak self] _, generate in
                    guard let strongSelf = self else {
                        return
                    }
                    let imageSize = CGSize(width: 228.0, height: 228.0)
                    let context = generate(TransformImageArguments(corners: ImageCorners(), imageSize: imageSize, boundingSize: imageSize, intrinsicInsets: UIEdgeInsets()))
                    if let image = context?.generateImage() {
                        strongSelf.controllerNode.updateQrImage(image)
                    }
                })
                
                let timestamp = Int32(Date().timeIntervalSince1970)
                let timeout = max(5, token.validUntil - timestamp)
                strongSelf.exportTokenDisposable.set((Signal<Never, NoError>.complete()
                |> delay(Double(timeout), queue: .mainQueue())).startStrict(completed: { [weak self] in
                    self?.refreshQrToken()
                }))
            case let .changeAccountAndRetry(updatedAccount):
                strongSelf.exportTokenDisposable.set(nil)
                strongSelf.account = updatedAccount
                strongSelf.accountUpdated?(updatedAccount)
                strongSelf.tokenEventsDisposable.set((updatedAccount.updateLoginTokenEvents
                |> deliverOnMainQueue).startStrict(next: { [weak self] _ in
                    self?.refreshQrToken()
                }))
                strongSelf.refreshQrToken()
            case .loggedIn:
                strongSelf.exportTokenDisposable.set(nil)
            case .passwordRequested:
                strongSelf.exportTokenDisposable.set(nil)
                strongSelf.dismiss()
            }
        }))
    }
    
    override public func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        self.controllerNode.containerLayoutUpdated(layout, navigationBarHeight: self.navigationLayout(layout: layout).navigationFrame.maxY, transition: transition)
    }
}
