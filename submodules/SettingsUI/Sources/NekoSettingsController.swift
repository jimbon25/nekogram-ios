import Foundation
import UIKit
import Display
import SwiftSignalKit
import TelegramCore
import TelegramPresentationData
import TelegramUIPreferences
import ItemListUI
import PresentationDataUtils
import AccountContext

private struct NekoSettingsState: Equatable {
    var formatTimeWithSeconds: Bool
    var hidePhoneNumber: Bool
    var ignoreContentRestrictions: Bool
    var disableNumberRounding: Bool
    var doubleTapAction: NekoDoubleTapAction
    var confirmSendSticker: Bool
    var hideStories: Bool
    var noQuoteForward: Bool
    var showIdAndDc: Bool
    var disableJumpToNextChannel: Bool
    var askBeforeCall: Bool
    var confirmSendVoice: Bool
    var showMessageDetails: Bool
    
    init() {
        self.formatTimeWithSeconds = NekoSettings.shared.formatTimeWithSeconds
        self.hidePhoneNumber = NekoSettings.shared.hidePhoneNumber
        self.ignoreContentRestrictions = NekoSettings.shared.ignoreContentRestrictions
        self.disableNumberRounding = NekoSettings.shared.disableNumberRounding
        self.doubleTapAction = NekoSettings.shared.doubleTapAction
        self.confirmSendSticker = NekoSettings.shared.confirmSendSticker
        self.hideStories = NekoSettings.shared.hideStories
        self.noQuoteForward = NekoSettings.shared.noQuoteForward
        self.showIdAndDc = NekoSettings.shared.showIdAndDc
        self.disableJumpToNextChannel = NekoSettings.shared.disableJumpToNextChannel
        self.askBeforeCall = NekoSettings.shared.askBeforeCall
        self.confirmSendVoice = NekoSettings.shared.confirmSendVoice
        self.showMessageDetails = NekoSettings.shared.showMessageDetails
    }
}

private final class NekoSettingsControllerArguments {
    let toggleFormatWithSeconds: (Bool) -> Void
    let toggleHidePhoneNumber: (Bool) -> Void
    let toggleIgnoreContentRestrictions: (Bool) -> Void
    let toggleDisableNumberRounding: (Bool) -> Void
    let toggleConfirmSendSticker: (Bool) -> Void
    let toggleHideStories: (Bool) -> Void
    let toggleNoQuoteForward: (Bool) -> Void
    let toggleShowIdAndDc: (Bool) -> Void
    let toggleDisableJumpToNextChannel: (Bool) -> Void
    let toggleAskBeforeCall: (Bool) -> Void
    let toggleConfirmSendVoice: (Bool) -> Void
    let toggleShowMessageDetails: (Bool) -> Void
    let openDoubleTapAction: () -> Void
    
    init(
        toggleFormatWithSeconds: @escaping (Bool) -> Void,
        toggleHidePhoneNumber: @escaping (Bool) -> Void,
        toggleIgnoreContentRestrictions: @escaping (Bool) -> Void,
        toggleDisableNumberRounding: @escaping (Bool) -> Void,
        toggleConfirmSendSticker: @escaping (Bool) -> Void,
        toggleHideStories: @escaping (Bool) -> Void,
        toggleNoQuoteForward: @escaping (Bool) -> Void,
        toggleShowIdAndDc: @escaping (Bool) -> Void,
        toggleDisableJumpToNextChannel: @escaping (Bool) -> Void,
        toggleAskBeforeCall: @escaping (Bool) -> Void,
        toggleConfirmSendVoice: @escaping (Bool) -> Void,
        toggleShowMessageDetails: @escaping (Bool) -> Void,
        openDoubleTapAction: @escaping () -> Void
    ) {
        self.toggleFormatWithSeconds = toggleFormatWithSeconds
        self.toggleHidePhoneNumber = toggleHidePhoneNumber
        self.toggleIgnoreContentRestrictions = toggleIgnoreContentRestrictions
        self.toggleDisableNumberRounding = toggleDisableNumberRounding
        self.toggleConfirmSendSticker = toggleConfirmSendSticker
        self.toggleHideStories = toggleHideStories
        self.toggleNoQuoteForward = toggleNoQuoteForward
        self.toggleShowIdAndDc = toggleShowIdAndDc
        self.toggleDisableJumpToNextChannel = toggleDisableJumpToNextChannel
        self.toggleAskBeforeCall = toggleAskBeforeCall
        self.toggleConfirmSendVoice = toggleConfirmSendVoice
        self.toggleShowMessageDetails = toggleShowMessageDetails
        self.openDoubleTapAction = openDoubleTapAction
    }
}

private enum NekoSettingsSection: Int32 {
    case general
    case appearance
    case chat
    case about
}

private enum NekoSettingsControllerEntry: ItemListNodeEntry {
    case generalHeader
    case hidePhoneNumber(Bool)
    case hidePhoneNumberFooter
    case showIdAndDc(Bool)
    case showIdAndDcFooter
    case askBeforeCall(Bool)
    case askBeforeCallFooter
    case ignoreRestrictions(Bool)
    case ignoreRestrictionsFooter
    case disableRounding(Bool)
    case disableRoundingFooter
    
    case appearanceHeader
    case formatWithSeconds(Bool)
    case formatWithSecondsFooter
    case hideStories(Bool)
    case hideStoriesFooter
    
    case chatHeader
    case noQuoteForward(Bool)
    case noQuoteForwardFooter
    case disableJumpToNextChannel(Bool)
    case disableJumpToNextChannelFooter
    case confirmSendVoice(Bool)
    case confirmSendVoiceFooter
    case showMessageDetails(Bool)
    case showMessageDetailsFooter
    case doubleTapAction(String)
    case doubleTapActionFooter
    case confirmSendSticker(Bool)
    case confirmSendStickerFooter
    
    case aboutHeader
    case aboutInfo
    
    var section: ItemListSectionId {
        switch self {
        case .generalHeader, .hidePhoneNumber, .hidePhoneNumberFooter, .showIdAndDc, .showIdAndDcFooter, .askBeforeCall, .askBeforeCallFooter, .ignoreRestrictions, .ignoreRestrictionsFooter, .disableRounding, .disableRoundingFooter:
            return NekoSettingsSection.general.rawValue
        case .appearanceHeader, .formatWithSeconds, .formatWithSecondsFooter, .hideStories, .hideStoriesFooter:
            return NekoSettingsSection.appearance.rawValue
        case .chatHeader, .noQuoteForward, .noQuoteForwardFooter, .disableJumpToNextChannel, .disableJumpToNextChannelFooter, .confirmSendVoice, .confirmSendVoiceFooter, .showMessageDetails, .showMessageDetailsFooter, .doubleTapAction, .doubleTapActionFooter, .confirmSendSticker, .confirmSendStickerFooter:
            return NekoSettingsSection.chat.rawValue
        case .aboutHeader, .aboutInfo:
            return NekoSettingsSection.about.rawValue
        }
    }
    
    var stableId: Int32 {
        switch self {
        case .generalHeader: return 0
        case .hidePhoneNumber: return 1
        case .hidePhoneNumberFooter: return 2
        case .showIdAndDc: return 3
        case .showIdAndDcFooter: return 4
        case .askBeforeCall: return 5
        case .askBeforeCallFooter: return 6
        case .ignoreRestrictions: return 7
        case .ignoreRestrictionsFooter: return 8
        case .disableRounding: return 9
        case .disableRoundingFooter: return 10
        case .appearanceHeader: return 11
        case .formatWithSeconds: return 12
        case .formatWithSecondsFooter: return 13
        case .hideStories: return 14
        case .hideStoriesFooter: return 15
        case .chatHeader: return 16
        case .noQuoteForward: return 17
        case .noQuoteForwardFooter: return 18
        case .disableJumpToNextChannel: return 19
        case .disableJumpToNextChannelFooter: return 20
        case .confirmSendVoice: return 21
        case .confirmSendVoiceFooter: return 22
        case .showMessageDetails: return 23
        case .showMessageDetailsFooter: return 24
        case .doubleTapAction: return 25
        case .doubleTapActionFooter: return 26
        case .confirmSendSticker: return 27
        case .confirmSendStickerFooter: return 28
        case .aboutHeader: return 29
        case .aboutInfo: return 30
        }
    }
    
    static func <(lhs: NekoSettingsControllerEntry, rhs: NekoSettingsControllerEntry) -> Bool {
        return lhs.stableId < rhs.stableId
    }
    
    static func ==(lhs: NekoSettingsControllerEntry, rhs: NekoSettingsControllerEntry) -> Bool {
        switch lhs {
        case .generalHeader:
            if case .generalHeader = rhs { return true } else { return false }
        case let .hidePhoneNumber(value):
            if case let .hidePhoneNumber(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hidePhoneNumberFooter:
            if case .hidePhoneNumberFooter = rhs { return true } else { return false }
        case let .showIdAndDc(value):
            if case let .showIdAndDc(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showIdAndDcFooter:
            if case .showIdAndDcFooter = rhs { return true } else { return false }
        case let .askBeforeCall(value):
            if case let .askBeforeCall(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .askBeforeCallFooter:
            if case .askBeforeCallFooter = rhs { return true } else { return false }
        case let .ignoreRestrictions(value):
            if case let .ignoreRestrictions(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .ignoreRestrictionsFooter:
            if case .ignoreRestrictionsFooter = rhs { return true } else { return false }
        case let .disableRounding(value):
            if case let .disableRounding(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableRoundingFooter:
            if case .disableRoundingFooter = rhs { return true } else { return false }
        case .appearanceHeader:
            if case .appearanceHeader = rhs { return true } else { return false }
        case let .formatWithSeconds(value):
            if case let .formatWithSeconds(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .formatWithSecondsFooter:
            if case .formatWithSecondsFooter = rhs { return true } else { return false }
        case let .hideStories(value):
            if case let .hideStories(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hideStoriesFooter:
            if case .hideStoriesFooter = rhs { return true } else { return false }
        case .chatHeader:
            if case .chatHeader = rhs { return true } else { return false }
        case let .noQuoteForward(value):
            if case let .noQuoteForward(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .noQuoteForwardFooter:
            if case .noQuoteForwardFooter = rhs { return true } else { return false }
        case let .disableJumpToNextChannel(value):
            if case let .disableJumpToNextChannel(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableJumpToNextChannelFooter:
            if case .disableJumpToNextChannelFooter = rhs { return true } else { return false }
        case let .confirmSendVoice(value):
            if case let .confirmSendVoice(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .confirmSendVoiceFooter:
            if case .confirmSendVoiceFooter = rhs { return true } else { return false }
        case let .showMessageDetails(value):
            if case let .showMessageDetails(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showMessageDetailsFooter:
            if case .showMessageDetailsFooter = rhs { return true } else { return false }
        case let .doubleTapAction(value):
            if case let .doubleTapAction(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .doubleTapActionFooter:
            if case .doubleTapActionFooter = rhs { return true } else { return false }
        case let .confirmSendSticker(value):
            if case let .confirmSendSticker(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .confirmSendStickerFooter:
            if case .confirmSendStickerFooter = rhs { return true } else { return false }
        case .aboutHeader:
            if case .aboutHeader = rhs { return true } else { return false }
        case .aboutInfo:
            if case .aboutInfo = rhs { return true } else { return false }
        }
    }
    
    func item(presentationData: ItemListPresentationData, arguments: Any) -> ListViewItem {
        let arguments = arguments as! NekoSettingsControllerArguments
        switch self {
        case .generalHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: "GENERAL", sectionId: self.section)
        case let .hidePhoneNumber(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Hide Phone Number", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHidePhoneNumber(value)
            })
        case .hidePhoneNumberFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Mask your phone number in Settings and Profile headers."), sectionId: self.section)
        case let .showIdAndDc(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Show ID in Profile", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowIdAndDc(value)
            })
        case .showIdAndDcFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Show Telegram ID row in user and channel profile details with tap to copy."), sectionId: self.section)
        case let .askBeforeCall(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Ask Before Calling", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleAskBeforeCall(value)
            })
        case .askBeforeCallFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Show confirmation dialog before initiating voice or video calls to prevent accidental calls."), sectionId: self.section)
        case let .ignoreRestrictions(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Ignore Content Restrictions", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleIgnoreContentRestrictions(value)
            })
        case .ignoreRestrictionsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Bypass regional and Apple platform content restrictions on channels and groups."), sectionId: self.section)
        case let .disableRounding(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Disable Number Rounding", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableNumberRounding(value)
            })
        case .disableRoundingFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Show exact numbers for views and member counts (e.g. 4777 instead of 4.8K)."), sectionId: self.section)
        case .appearanceHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: "APPEARANCE", sectionId: self.section)
        case let .formatWithSeconds(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Time with Seconds", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleFormatWithSeconds(value)
            })
        case .formatWithSecondsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Show seconds in message timestamps (e.g. 14:23:45)."), sectionId: self.section)
        case let .hideStories(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Hide Stories Bar", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHideStories(value)
            })
        case .hideStoriesFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Hide the stories bar at the top of the chat list for a cleaner view."), sectionId: self.section)
        case .chatHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: "CHAT", sectionId: self.section)
        case let .noQuoteForward(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Forward without Quote", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleNoQuoteForward(value)
            })
        case .noQuoteForwardFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Automatically forward messages without sender attribution."), sectionId: self.section)
        case let .disableJumpToNextChannel(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Disable Jump to Next Channel", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableJumpToNextChannel(value)
            })
        case .disableJumpToNextChannelFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Prevent automatically switching to the next unread channel when scrolling past the last message."), sectionId: self.section)
        case let .confirmSendVoice(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Confirm Send Voice / Video", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleConfirmSendVoice(value)
            })
        case .confirmSendVoiceFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Ask for confirmation before sending recorded voice or video notes."), sectionId: self.section)
        case let .showMessageDetails(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Message Details in Menu", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowMessageDetails(value)
            })
        case .showMessageDetailsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Add Message Details option to message context menu showing ID, timestamp, and peer info."), sectionId: self.section)
        case let .doubleTapAction(title):
            return ItemListDisclosureItem(presentationData: presentationData, title: "Double Tap Action", label: title, sectionId: self.section, style: .blocks, action: {
                arguments.openDoubleTapAction()
            })
        case .doubleTapActionFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Choose the action performed when double tapping a message bubble."), sectionId: self.section)
        case let .confirmSendSticker(value):
            return ItemListSwitchItem(presentationData: presentationData, title: "Confirm Send Sticker", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleConfirmSendSticker(value)
            })
        case .confirmSendStickerFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain("Ask for confirmation before sending a sticker to avoid accidental taps."), sectionId: self.section)
        case .aboutHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: "ABOUT", sectionId: self.section)
        case .aboutInfo:
            return ItemListTextItem(presentationData: presentationData, text: .markdown("**Nekogram for iOS**\nEssential Nekogram enhancements for Telegram iOS.\nPorted by Dayumm & Makima."), sectionId: self.section)
        }
    }
}

private func nekoSettingsControllerEntries(presentationData: PresentationData, state: NekoSettingsState) -> [NekoSettingsControllerEntry] {
    var entries: [NekoSettingsControllerEntry] = []
    
    entries.append(.generalHeader)
    entries.append(.hidePhoneNumber(state.hidePhoneNumber))
    entries.append(.hidePhoneNumberFooter)
    entries.append(.showIdAndDc(state.showIdAndDc))
    entries.append(.showIdAndDcFooter)
    entries.append(.askBeforeCall(state.askBeforeCall))
    entries.append(.askBeforeCallFooter)
    entries.append(.ignoreRestrictions(state.ignoreContentRestrictions))
    entries.append(.ignoreRestrictionsFooter)
    entries.append(.disableRounding(state.disableNumberRounding))
    entries.append(.disableRoundingFooter)
    
    entries.append(.appearanceHeader)
    entries.append(.formatWithSeconds(state.formatTimeWithSeconds))
    entries.append(.formatWithSecondsFooter)
    entries.append(.hideStories(state.hideStories))
    entries.append(.hideStoriesFooter)
    
    entries.append(.chatHeader)
    entries.append(.noQuoteForward(state.noQuoteForward))
    entries.append(.noQuoteForwardFooter)
    entries.append(.disableJumpToNextChannel(state.disableJumpToNextChannel))
    entries.append(.disableJumpToNextChannelFooter)
    entries.append(.confirmSendVoice(state.confirmSendVoice))
    entries.append(.confirmSendVoiceFooter)
    entries.append(.showMessageDetails(state.showMessageDetails))
    entries.append(.showMessageDetailsFooter)
    entries.append(.doubleTapAction(state.doubleTapAction.title))
    entries.append(.doubleTapActionFooter)
    entries.append(.confirmSendSticker(state.confirmSendSticker))
    entries.append(.confirmSendStickerFooter)
    
    entries.append(.aboutHeader)
    entries.append(.aboutInfo)
    
    return entries
}

public func nekoSettingsController(context: AccountContext) -> ViewController {
    let statePromise = ValuePromise(NekoSettingsState(), ignoreRepeated: true)
    
    var presentControllerImpl: ((ViewController, Any?) -> Void)?
    
    let arguments = NekoSettingsControllerArguments(
        toggleFormatWithSeconds: { value in
            NekoSettings.shared.formatTimeWithSeconds = value
            statePromise.set(NekoSettingsState())
        },
        toggleHidePhoneNumber: { value in
            NekoSettings.shared.hidePhoneNumber = value
            statePromise.set(NekoSettingsState())
        },
        toggleIgnoreContentRestrictions: { value in
            NekoSettings.shared.ignoreContentRestrictions = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableNumberRounding: { value in
            NekoSettings.shared.disableNumberRounding = value
            statePromise.set(NekoSettingsState())
        },
        toggleConfirmSendSticker: { value in
            NekoSettings.shared.confirmSendSticker = value
            statePromise.set(NekoSettingsState())
        },
        toggleHideStories: { value in
            NekoSettings.shared.hideStories = value
            statePromise.set(NekoSettingsState())
        },
        toggleNoQuoteForward: { value in
            NekoSettings.shared.noQuoteForward = value
            statePromise.set(NekoSettingsState())
        },
        toggleShowIdAndDc: { value in
            NekoSettings.shared.showIdAndDc = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableJumpToNextChannel: { value in
            NekoSettings.shared.disableJumpToNextChannel = value
            statePromise.set(NekoSettingsState())
        },
        toggleAskBeforeCall: { value in
            NekoSettings.shared.askBeforeCall = value
            statePromise.set(NekoSettingsState())
        },
        toggleConfirmSendVoice: { value in
            NekoSettings.shared.confirmSendVoice = value
            statePromise.set(NekoSettingsState())
        },
        toggleShowMessageDetails: { value in
            NekoSettings.shared.showMessageDetails = value
            statePromise.set(NekoSettingsState())
        },
        openDoubleTapAction: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let actionSheet = ActionSheetController(presentationData: presentationData)
            var items: [ActionSheetItem] = []
            for action in NekoDoubleTapAction.allCases {
                items.append(ActionSheetButtonItem(title: action.title, color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.doubleTapAction = action
                    statePromise.set(NekoSettingsState())
                }))
            }
            actionSheet.setItemGroups([
                ActionSheetItemGroup(items: items),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, color: .accent, font: .bold, action: { [weak actionSheet] in
                        actionSheet?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(actionSheet, nil)
        }
    )
    
    let signal = combineLatest(queue: .mainQueue(),
        context.sharedContext.presentationData,
        statePromise.get()
    )
    |> deliverOnMainQueue
    |> map { presentationData, state -> (ItemListControllerState, (ItemListNodeState, Any)) in
        var presentationData = presentationData
        let updatedTheme = presentationData.theme.withModalBlocksBackground()
        presentationData = presentationData.withUpdated(theme: updatedTheme)
        
        let controllerState = ItemListControllerState(
            presentationData: ItemListPresentationData(presentationData),
            title: .text("Nekogram Settings"),
            leftNavigationButton: nil,
            rightNavigationButton: nil,
            backNavigationButton: ItemListBackButton(title: presentationData.strings.Common_Back)
        )
        let listState = ItemListNodeState(
            presentationData: ItemListPresentationData(presentationData),
            entries: nekoSettingsControllerEntries(presentationData: presentationData, state: state),
            style: .blocks,
            animateChanges: false
        )
        
        return (controllerState, (listState, arguments))
    }
    
    let controller = ItemListController(context: context, state: signal)
    presentControllerImpl = { [weak controller] c, a in
        controller?.present(c, in: .window(.root))
    }
    
    return controller
}
