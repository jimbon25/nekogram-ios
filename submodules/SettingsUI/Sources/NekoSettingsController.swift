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
    var suppressTyping: Bool
    var disableProximitySensor: Bool
    var expandRecentStickers: Bool
    var dismissKeyboardOnScroll: Bool
    var hideAllChatsTab: Bool
    var silenceNonContacts: Bool
    var ignoreBlockedInGroups: Bool
    var chatIdFormatBotApi: Bool
    var repeatMessageAction: Bool
    var disableGreetingSticker: Bool
    var hideTimeOnStickers: Bool
    var downloadSpeedBoost: Bool
    var toastRpcErrors: Bool
    var defaultMarkdown: Bool
    var skipReadHistory: Bool
    var disableVoiceMessageAutoPlay: Bool
    var showQrCode: Bool
    var disableAppBarShadow: Bool
    var showPrPr: Bool
    var hideChannelBottomButtons: Bool
    var tryOpenInstantView: Bool
    var tabTitleType: Int
    var translationProvider: Int
    var miniSenderAvatar: Bool
    
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
        self.suppressTyping = NekoSettings.shared.suppressTyping
        self.disableProximitySensor = NekoSettings.shared.disableProximitySensor
        self.expandRecentStickers = NekoSettings.shared.expandRecentStickers
        self.dismissKeyboardOnScroll = NekoSettings.shared.dismissKeyboardOnScroll
        self.hideAllChatsTab = NekoSettings.shared.hideAllChatsTab
        self.silenceNonContacts = NekoSettings.shared.silenceNonContacts
        self.ignoreBlockedInGroups = NekoSettings.shared.ignoreBlockedInGroups
        self.chatIdFormatBotApi = NekoSettings.shared.chatIdFormatBotApi
        self.repeatMessageAction = NekoSettings.shared.repeatMessageAction
        self.disableGreetingSticker = NekoSettings.shared.disableGreetingSticker
        self.hideTimeOnStickers = NekoSettings.shared.hideTimeOnStickers
        self.downloadSpeedBoost = NekoSettings.shared.downloadSpeedBoost
        self.toastRpcErrors = NekoSettings.shared.toastRpcErrors
        self.defaultMarkdown = NekoSettings.shared.defaultMarkdown
        self.skipReadHistory = NekoSettings.shared.skipReadHistory
        self.disableVoiceMessageAutoPlay = NekoSettings.shared.disableVoiceMessageAutoPlay
        self.showQrCode = NekoSettings.shared.showQrCode
        self.disableAppBarShadow = NekoSettings.shared.disableAppBarShadow
        self.showPrPr = NekoSettings.shared.showPrPr
        self.hideChannelBottomButtons = NekoSettings.shared.hideChannelBottomButtons
        self.tryOpenInstantView = NekoSettings.shared.tryOpenInstantView
        self.tabTitleType = NekoSettings.shared.tabTitleType
        self.translationProvider = NekoSettings.shared.translationProvider
        self.miniSenderAvatar = NekoSettings.shared.miniSenderAvatar
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
    let toggleSuppressTyping: (Bool) -> Void
    let toggleDisableProximitySensor: (Bool) -> Void
    let toggleExpandRecentStickers: (Bool) -> Void
    let toggleDismissKeyboardOnScroll: (Bool) -> Void
    let toggleHideAllChatsTab: (Bool) -> Void
    let toggleSilenceNonContacts: (Bool) -> Void
    let toggleIgnoreBlockedInGroups: (Bool) -> Void
    let toggleChatIdFormatBotApi: (Bool) -> Void
    let toggleRepeatMessageAction: (Bool) -> Void
    let toggleDisableGreetingSticker: (Bool) -> Void
    let toggleHideTimeOnStickers: (Bool) -> Void
    let toggleDownloadSpeedBoost: (Bool) -> Void
    let toggleToastRpcErrors: (Bool) -> Void
    let toggleDefaultMarkdown: (Bool) -> Void
    let toggleSkipReadHistory: (Bool) -> Void
    let toggleDisableVoiceMessageAutoPlay: (Bool) -> Void
    let toggleShowQrCode: (Bool) -> Void
    let toggleDisableAppBarShadow: (Bool) -> Void
    let toggleShowPrPr: (Bool) -> Void
    let toggleHideChannelBottomButtons: (Bool) -> Void
    let toggleTryOpenInstantView: (Bool) -> Void
    let openTabTitleTypeMenu: () -> Void
    let openTranslationProviderMenu: () -> Void
    let toggleMiniSenderAvatar: (Bool) -> Void
    let openNameOrderMenu: () -> Void
    let openDoubleTapAction: () -> Void
    let openAppIconSettings: () -> Void
    let openUrl: (String) -> Void
    
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
        toggleSuppressTyping: @escaping (Bool) -> Void,
        toggleDisableProximitySensor: @escaping (Bool) -> Void,
        toggleExpandRecentStickers: @escaping (Bool) -> Void,
        toggleDismissKeyboardOnScroll: @escaping (Bool) -> Void,
        toggleHideAllChatsTab: @escaping (Bool) -> Void,
        toggleSilenceNonContacts: @escaping (Bool) -> Void,
        toggleIgnoreBlockedInGroups: @escaping (Bool) -> Void,
        toggleChatIdFormatBotApi: @escaping (Bool) -> Void,
        toggleRepeatMessageAction: @escaping (Bool) -> Void,
        toggleDisableGreetingSticker: @escaping (Bool) -> Void,
        toggleHideTimeOnStickers: @escaping (Bool) -> Void,
        toggleDownloadSpeedBoost: @escaping (Bool) -> Void,
        toggleToastRpcErrors: @escaping (Bool) -> Void,
        toggleDefaultMarkdown: @escaping (Bool) -> Void,
        toggleSkipReadHistory: @escaping (Bool) -> Void,
        toggleDisableVoiceMessageAutoPlay: @escaping (Bool) -> Void,
        toggleShowQrCode: @escaping (Bool) -> Void,
        toggleDisableAppBarShadow: @escaping (Bool) -> Void,
        toggleShowPrPr: @escaping (Bool) -> Void,
        toggleHideChannelBottomButtons: @escaping (Bool) -> Void,
        toggleTryOpenInstantView: @escaping (Bool) -> Void,
        openTabTitleTypeMenu: @escaping () -> Void,
        openTranslationProviderMenu: @escaping () -> Void,
        toggleMiniSenderAvatar: @escaping (Bool) -> Void,
        openNameOrderMenu: @escaping () -> Void,
        openDoubleTapAction: @escaping () -> Void,
        openAppIconSettings: @escaping () -> Void,
        openUrl: @escaping (String) -> Void
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
        self.toggleSuppressTyping = toggleSuppressTyping
        self.toggleDisableProximitySensor = toggleDisableProximitySensor
        self.toggleExpandRecentStickers = toggleExpandRecentStickers
        self.toggleDismissKeyboardOnScroll = toggleDismissKeyboardOnScroll
        self.toggleHideAllChatsTab = toggleHideAllChatsTab
        self.toggleSilenceNonContacts = toggleSilenceNonContacts
        self.toggleIgnoreBlockedInGroups = toggleIgnoreBlockedInGroups
        self.toggleChatIdFormatBotApi = toggleChatIdFormatBotApi
        self.toggleRepeatMessageAction = toggleRepeatMessageAction
        self.toggleDisableGreetingSticker = toggleDisableGreetingSticker
        self.toggleHideTimeOnStickers = toggleHideTimeOnStickers
        self.toggleDownloadSpeedBoost = toggleDownloadSpeedBoost
        self.toggleToastRpcErrors = toggleToastRpcErrors
        self.toggleDefaultMarkdown = toggleDefaultMarkdown
        self.toggleSkipReadHistory = toggleSkipReadHistory
        self.toggleDisableVoiceMessageAutoPlay = toggleDisableVoiceMessageAutoPlay
        self.toggleShowQrCode = toggleShowQrCode
        self.toggleDisableAppBarShadow = toggleDisableAppBarShadow
        self.toggleShowPrPr = toggleShowPrPr
        self.toggleHideChannelBottomButtons = toggleHideChannelBottomButtons
        self.toggleTryOpenInstantView = toggleTryOpenInstantView
        self.openTabTitleTypeMenu = openTabTitleTypeMenu
        self.openTranslationProviderMenu = openTranslationProviderMenu
        self.toggleMiniSenderAvatar = toggleMiniSenderAvatar
        self.openNameOrderMenu = openNameOrderMenu
        self.openDoubleTapAction = openDoubleTapAction
        self.openAppIconSettings = openAppIconSettings
        self.openUrl = openUrl
    }
}

private enum NekoSettingsSection: Int32 {
    case general
    case privacy
    case appearance
    case chat
    case about
}

private enum NekoSettingsControllerEntry: ItemListNodeEntry {
    case generalHeader
    case nameOrder(PresentationPersonNameOrder)
    case nameOrderFooter
    case showIdAndDc(Bool)
    case showIdAndDcFooter
    case chatIdFormatBotApi(Bool)
    case chatIdFormatBotApiFooter
    
    case privacyHeader
    case suppressTyping(Bool)
    case suppressTypingFooter
    case silenceNonContacts(Bool)
    case silenceNonContactsFooter
    case ignoreBlockedInGroups(Bool)
    case ignoreBlockedInGroupsFooter
    case hidePhoneNumber(Bool)
    case hidePhoneNumberFooter
    case askBeforeCall(Bool)
    case askBeforeCallFooter
    case ignoreRestrictions(Bool)
    case ignoreRestrictionsFooter
    case skipReadHistory(Bool)
    case skipReadHistoryFooter
    
    case appearanceHeader
    case formatWithSeconds(Bool)
    case formatWithSecondsFooter
    case hideStories(Bool)
    case hideStoriesFooter
    case hideAllChatsTab(Bool)
    case hideAllChatsTabFooter
    case disableRounding(Bool)
    case disableRoundingFooter
    case appIcon
    case appIconFooter
    case disableAppBarShadow(Bool)
    case disableAppBarShadowFooter
    case tabTitleType(String)
    case tabTitleTypeFooter
    
    case chatHeader
    case noQuoteForward(Bool)
    case noQuoteForwardFooter
    case repeatMessageAction(Bool)
    case repeatMessageActionFooter
    case disableGreetingSticker(Bool)
    case disableGreetingStickerFooter
    case hideTimeOnStickers(Bool)
    case hideTimeOnStickersFooter
    case disableJumpToNextChannel(Bool)
    case disableJumpToNextChannelFooter
    case confirmSendVoice(Bool)
    case confirmSendVoiceFooter
    case confirmSendSticker(Bool)
    case confirmSendStickerFooter
    case dismissKeyboardOnScroll(Bool)
    case dismissKeyboardOnScrollFooter
    case expandRecentStickers(Bool)
    case expandRecentStickersFooter
    case disableProximitySensor(Bool)
    case disableProximitySensorFooter
    case showMessageDetails(Bool)
    case showMessageDetailsFooter
    case doubleTapAction(String)
    case doubleTapActionFooter
    case defaultMarkdown(Bool)
    case defaultMarkdownFooter
    case downloadSpeedBoost(Bool)
    case downloadSpeedBoostFooter
    case toastRpcErrors(Bool)
    case toastRpcErrorsFooter
    case disableVoiceMessageAutoPlay(Bool)
    case disableVoiceMessageAutoPlayFooter
    case showQrCode(Bool)
    case showQrCodeFooter
    case showPrPr(Bool)
    case showPrPrFooter
    case hideChannelBottomButtons(Bool)
    case hideChannelBottomButtonsFooter
    case tryOpenInstantView(Bool)
    case tryOpenInstantViewFooter
    case translationProvider(String)
    case translationProviderFooter
    case miniSenderAvatar(Bool)
    case miniSenderAvatarFooter
    
    case aboutHeader
    case aboutVersion(String)
    case aboutUpstream(String)
    case aboutSourceCode
    case aboutInspiration
    case aboutFooter
    
    var section: ItemListSectionId {
        switch self {
        case .generalHeader, .nameOrder, .nameOrderFooter, .showIdAndDc, .showIdAndDcFooter, .chatIdFormatBotApi, .chatIdFormatBotApiFooter:
            return NekoSettingsSection.general.rawValue
        case .privacyHeader, .suppressTyping, .suppressTypingFooter, .silenceNonContacts, .silenceNonContactsFooter, .ignoreBlockedInGroups, .ignoreBlockedInGroupsFooter, .hidePhoneNumber, .hidePhoneNumberFooter, .askBeforeCall, .askBeforeCallFooter, .ignoreRestrictions, .ignoreRestrictionsFooter, .skipReadHistory, .skipReadHistoryFooter:
            return NekoSettingsSection.privacy.rawValue
        case .appearanceHeader, .formatWithSeconds, .formatWithSecondsFooter, .hideStories, .hideStoriesFooter, .hideAllChatsTab, .hideAllChatsTabFooter, .disableRounding, .disableRoundingFooter, .appIcon, .appIconFooter, .disableAppBarShadow, .disableAppBarShadowFooter, .tabTitleType, .tabTitleTypeFooter:
            return NekoSettingsSection.appearance.rawValue
        case .chatHeader, .noQuoteForward, .noQuoteForwardFooter, .repeatMessageAction, .repeatMessageActionFooter, .disableGreetingSticker, .disableGreetingStickerFooter, .hideTimeOnStickers, .hideTimeOnStickersFooter, .disableJumpToNextChannel, .disableJumpToNextChannelFooter, .confirmSendVoice, .confirmSendVoiceFooter, .confirmSendSticker, .confirmSendStickerFooter, .dismissKeyboardOnScroll, .dismissKeyboardOnScrollFooter, .expandRecentStickers, .expandRecentStickersFooter, .disableProximitySensor, .disableProximitySensorFooter, .showMessageDetails, .showMessageDetailsFooter, .doubleTapAction, .doubleTapActionFooter, .defaultMarkdown, .defaultMarkdownFooter, .downloadSpeedBoost, .downloadSpeedBoostFooter, .toastRpcErrors, .toastRpcErrorsFooter, .disableVoiceMessageAutoPlay, .disableVoiceMessageAutoPlayFooter, .showQrCode, .showQrCodeFooter, .showPrPr, .showPrPrFooter, .hideChannelBottomButtons, .hideChannelBottomButtonsFooter, .tryOpenInstantView, .tryOpenInstantViewFooter, .translationProvider, .translationProviderFooter, .miniSenderAvatar, .miniSenderAvatarFooter:
            return NekoSettingsSection.chat.rawValue
        case .aboutHeader, .aboutVersion, .aboutUpstream, .aboutSourceCode, .aboutInspiration, .aboutFooter:
            return NekoSettingsSection.about.rawValue
        }
    }
    
    var stableId: Int32 {
        switch self {
        case .generalHeader: return 0
        case .nameOrder: return 1
        case .nameOrderFooter: return 2
        case .showIdAndDc: return 3
        case .showIdAndDcFooter: return 4
        case .chatIdFormatBotApi: return 5
        case .chatIdFormatBotApiFooter: return 6
            
        case .privacyHeader: return 10
        case .suppressTyping: return 11
        case .suppressTypingFooter: return 12
        case .silenceNonContacts: return 13
        case .silenceNonContactsFooter: return 14
        case .ignoreBlockedInGroups: return 15
        case .ignoreBlockedInGroupsFooter: return 16
        case .hidePhoneNumber: return 17
        case .hidePhoneNumberFooter: return 18
        case .askBeforeCall: return 19
        case .askBeforeCallFooter: return 20
        case .ignoreRestrictions: return 21
        case .ignoreRestrictionsFooter: return 22
        case .skipReadHistory: return 23
        case .skipReadHistoryFooter: return 24
            
        case .appearanceHeader: return 30
        case .formatWithSeconds: return 31
        case .formatWithSecondsFooter: return 32
        case .hideStories: return 33
        case .hideStoriesFooter: return 34
        case .hideAllChatsTab: return 35
        case .hideAllChatsTabFooter: return 36
        case .disableRounding: return 37
        case .disableRoundingFooter: return 38
        case .appIcon: return 39
        case .appIconFooter: return 40
        case .disableAppBarShadow: return 41
        case .disableAppBarShadowFooter: return 42
        case .tabTitleType: return 43
        case .tabTitleTypeFooter: return 44
            
        case .chatHeader: return 50
        case .noQuoteForward: return 51
        case .noQuoteForwardFooter: return 52
        case .repeatMessageAction: return 53
        case .repeatMessageActionFooter: return 54
        case .disableGreetingSticker: return 55
        case .disableGreetingStickerFooter: return 56
        case .hideTimeOnStickers: return 57
        case .hideTimeOnStickersFooter: return 58
        case .disableJumpToNextChannel: return 59
        case .disableJumpToNextChannelFooter: return 60
        case .confirmSendVoice: return 61
        case .confirmSendVoiceFooter: return 62
        case .confirmSendSticker: return 63
        case .confirmSendStickerFooter: return 64
        case .dismissKeyboardOnScroll: return 65
        case .dismissKeyboardOnScrollFooter: return 66
        case .expandRecentStickers: return 67
        case .expandRecentStickersFooter: return 68
        case .disableProximitySensor: return 69
        case .disableProximitySensorFooter: return 70
        case .showMessageDetails: return 71
        case .showMessageDetailsFooter: return 72
        case .doubleTapAction: return 73
        case .doubleTapActionFooter: return 74
        case .defaultMarkdown: return 75
        case .defaultMarkdownFooter: return 76
        case .downloadSpeedBoost: return 77
        case .downloadSpeedBoostFooter: return 78
        case .toastRpcErrors: return 79
        case .toastRpcErrorsFooter: return 80
        case .disableVoiceMessageAutoPlay: return 81
        case .disableVoiceMessageAutoPlayFooter: return 82
        case .showQrCode: return 83
        case .showQrCodeFooter: return 84
        case .showPrPr: return 85
        case .showPrPrFooter: return 86
        case .hideChannelBottomButtons: return 87
        case .hideChannelBottomButtonsFooter: return 88
        case .tryOpenInstantView: return 89
        case .tryOpenInstantViewFooter: return 90
        case .translationProvider: return 91
        case .translationProviderFooter: return 92
        case .miniSenderAvatar: return 93
        case .miniSenderAvatarFooter: return 94
            
        case .aboutHeader: return 100
        case .aboutVersion: return 101
        case .aboutUpstream: return 102
        case .aboutSourceCode: return 103
        case .aboutInspiration: return 104
        case .aboutFooter: return 105
        }
    }
    
    static func <(lhs: NekoSettingsControllerEntry, rhs: NekoSettingsControllerEntry) -> Bool {
        return lhs.stableId < rhs.stableId
    }
    
    static func ==(lhs: NekoSettingsControllerEntry, rhs: NekoSettingsControllerEntry) -> Bool {
        switch lhs {
        case .generalHeader:
            if case .generalHeader = rhs { return true } else { return false }
        case let .nameOrder(value):
            if case let .nameOrder(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .nameOrderFooter:
            if case .nameOrderFooter = rhs { return true } else { return false }
        case let .showIdAndDc(value):
            if case let .showIdAndDc(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showIdAndDcFooter:
            if case .showIdAndDcFooter = rhs { return true } else { return false }
        case let .chatIdFormatBotApi(value):
            if case let .chatIdFormatBotApi(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .chatIdFormatBotApiFooter:
            if case .chatIdFormatBotApiFooter = rhs { return true } else { return false }
            
        case .privacyHeader:
            if case .privacyHeader = rhs { return true } else { return false }
        case let .suppressTyping(value):
            if case let .suppressTyping(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .suppressTypingFooter:
            if case .suppressTypingFooter = rhs { return true } else { return false }
        case let .silenceNonContacts(value):
            if case let .silenceNonContacts(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .silenceNonContactsFooter:
            if case .silenceNonContactsFooter = rhs { return true } else { return false }
        case let .ignoreBlockedInGroups(value):
            if case let .ignoreBlockedInGroups(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .ignoreBlockedInGroupsFooter:
            if case .ignoreBlockedInGroupsFooter = rhs { return true } else { return false }
        case let .hidePhoneNumber(value):
            if case let .hidePhoneNumber(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hidePhoneNumberFooter:
            if case .hidePhoneNumberFooter = rhs { return true } else { return false }
        case let .askBeforeCall(value):
            if case let .askBeforeCall(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .askBeforeCallFooter:
            if case .askBeforeCallFooter = rhs { return true } else { return false }
        case let .ignoreRestrictions(value):
            if case let .ignoreRestrictions(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .ignoreRestrictionsFooter:
            if case .ignoreRestrictionsFooter = rhs { return true } else { return false }
        case let .skipReadHistory(value):
            if case let .skipReadHistory(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .skipReadHistoryFooter:
            if case .skipReadHistoryFooter = rhs { return true } else { return false }
            
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
        case let .hideAllChatsTab(value):
            if case let .hideAllChatsTab(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hideAllChatsTabFooter:
            if case .hideAllChatsTabFooter = rhs { return true } else { return false }
        case let .disableRounding(value):
            if case let .disableRounding(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableRoundingFooter:
            if case .disableRoundingFooter = rhs { return true } else { return false }
        case .appIcon:
            if case .appIcon = rhs { return true } else { return false }
        case .appIconFooter:
            if case .appIconFooter = rhs { return true } else { return false }
        case let .disableAppBarShadow(value):
            if case let .disableAppBarShadow(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableAppBarShadowFooter:
            if case .disableAppBarShadowFooter = rhs { return true } else { return false }
        case let .tabTitleType(value):
            if case let .tabTitleType(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .tabTitleTypeFooter:
            if case .tabTitleTypeFooter = rhs { return true } else { return false }
            
        case .chatHeader:
            if case .chatHeader = rhs { return true } else { return false }
        case let .noQuoteForward(value):
            if case let .noQuoteForward(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .noQuoteForwardFooter:
            if case .noQuoteForwardFooter = rhs { return true } else { return false }
        case let .repeatMessageAction(value):
            if case let .repeatMessageAction(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .repeatMessageActionFooter:
            if case .repeatMessageActionFooter = rhs { return true } else { return false }
        case let .disableGreetingSticker(value):
            if case let .disableGreetingSticker(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableGreetingStickerFooter:
            if case .disableGreetingStickerFooter = rhs { return true } else { return false }
        case let .hideTimeOnStickers(value):
            if case let .hideTimeOnStickers(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hideTimeOnStickersFooter:
            if case .hideTimeOnStickersFooter = rhs { return true } else { return false }
        case let .disableJumpToNextChannel(value):
            if case let .disableJumpToNextChannel(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableJumpToNextChannelFooter:
            if case .disableJumpToNextChannelFooter = rhs { return true } else { return false }
        case let .confirmSendVoice(value):
            if case let .confirmSendVoice(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .confirmSendVoiceFooter:
            if case .confirmSendVoiceFooter = rhs { return true } else { return false }
        case let .confirmSendSticker(value):
            if case let .confirmSendSticker(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .confirmSendStickerFooter:
            if case .confirmSendStickerFooter = rhs { return true } else { return false }
        case let .dismissKeyboardOnScroll(value):
            if case let .dismissKeyboardOnScroll(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .dismissKeyboardOnScrollFooter:
            if case .dismissKeyboardOnScrollFooter = rhs { return true } else { return false }
        case let .expandRecentStickers(value):
            if case let .expandRecentStickers(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .expandRecentStickersFooter:
            if case .expandRecentStickersFooter = rhs { return true } else { return false }
        case let .disableProximitySensor(value):
            if case let .disableProximitySensor(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableProximitySensorFooter:
            if case .disableProximitySensorFooter = rhs { return true } else { return false }
        case let .showMessageDetails(value):
            if case let .showMessageDetails(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showMessageDetailsFooter:
            if case .showMessageDetailsFooter = rhs { return true } else { return false }
        case let .doubleTapAction(value):
            if case let .doubleTapAction(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .doubleTapActionFooter:
            if case .doubleTapActionFooter = rhs { return true } else { return false }
        case let .defaultMarkdown(value):
            if case let .defaultMarkdown(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .defaultMarkdownFooter:
            if case .defaultMarkdownFooter = rhs { return true } else { return false }
        case let .downloadSpeedBoost(value):
            if case let .downloadSpeedBoost(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .downloadSpeedBoostFooter:
            if case .downloadSpeedBoostFooter = rhs { return true } else { return false }
        case let .toastRpcErrors(value):
            if case let .toastRpcErrors(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .toastRpcErrorsFooter:
            if case .toastRpcErrorsFooter = rhs { return true } else { return false }
        case let .disableVoiceMessageAutoPlay(value):
            if case let .disableVoiceMessageAutoPlay(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .disableVoiceMessageAutoPlayFooter:
            if case .disableVoiceMessageAutoPlayFooter = rhs { return true } else { return false }
        case let .showQrCode(value):
            if case let .showQrCode(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showQrCodeFooter:
            if case .showQrCodeFooter = rhs { return true } else { return false }
        case let .showPrPr(value):
            if case let .showPrPr(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .showPrPrFooter:
            if case .showPrPrFooter = rhs { return true } else { return false }
        case let .hideChannelBottomButtons(value):
            if case let .hideChannelBottomButtons(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .hideChannelBottomButtonsFooter:
            if case .hideChannelBottomButtonsFooter = rhs { return true } else { return false }
        case let .tryOpenInstantView(value):
            if case let .tryOpenInstantView(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .tryOpenInstantViewFooter:
            if case .tryOpenInstantViewFooter = rhs { return true } else { return false }
        case let .translationProvider(value):
            if case let .translationProvider(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .translationProviderFooter:
            if case .translationProviderFooter = rhs { return true } else { return false }
        case let .miniSenderAvatar(value):
            if case let .miniSenderAvatar(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .miniSenderAvatarFooter:
            if case .miniSenderAvatarFooter = rhs { return true } else { return false }
            
        case .aboutHeader:
            if case .aboutHeader = rhs { return true } else { return false }
        case let .aboutVersion(value):
            if case let .aboutVersion(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case let .aboutUpstream(value):
            if case let .aboutUpstream(rhsValue) = rhs, value == rhsValue { return true } else { return false }
        case .aboutSourceCode:
            if case .aboutSourceCode = rhs { return true } else { return false }
        case .aboutInspiration:
            if case .aboutInspiration = rhs { return true } else { return false }
        case .aboutFooter:
            if case .aboutFooter = rhs { return true } else { return false }
        }
    }
    
    func item(presentationData: ItemListPresentationData, arguments: Any) -> ListViewItem {
        let arguments = arguments as! NekoSettingsControllerArguments
        let isId = presentationData.strings.primaryComponent.languageCode == "id"
        
        switch self {
        case .generalHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: isId ? "UMUM" : "GENERAL", sectionId: self.section)
        case let .nameOrder(order):
            let orderLabel: String
            if isId {
                orderLabel = (order == .firstLast) ? "Nama Depan Belakang (First Last)" : "Nama Belakang Depan (Last First)"
            } else {
                orderLabel = (order == .firstLast) ? "First Last" : "Last First"
            }
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Urutan Nama Kontak" : "Name Order", label: orderLabel, sectionId: self.section, style: .blocks, action: {
                arguments.openNameOrderMenu()
            })
        case .nameOrderFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Pilih susunan tampilan nama pengguna dan kontak antara Nama Depan lebih dulu atau Nama Belakang." : "Choose whether contact names are displayed as First Last or Last First."), sectionId: self.section)
        case let .showIdAndDc(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tampilkan ID di Profil" : "Show ID in Profile", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowIdAndDc(value)
            })
        case .showIdAndDcFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan baris Telegram ID di profil pengguna dan channel dengan fitur ketuk untuk menyalin." : "Show Telegram ID row in user and channel profile details with tap to copy."), sectionId: self.section)
        case let .chatIdFormatBotApi(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Format ID Bot API (-100...)" : "Bot API Chat ID Format", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleChatIdFormatBotApi(value)
            })
        case .chatIdFormatBotApiFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan ID channel dan supergrup dengan awalan -100 sesuai standar Telegram Bot API." : "Format channel and supergroup IDs with the -100 prefix conforming to Telegram Bot API standard."), sectionId: self.section)
            
        case .privacyHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: isId ? "PRIVASI & KEAMANAN" : "PRIVACY & SECURITY", sectionId: self.section)
        case let .suppressTyping(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Ghost Typing (Sembunyikan Mengetik)" : "Ghost Typing", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleSuppressTyping(value)
            })
        case .suppressTypingFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Cegah lawan bicara melihat saat Anda sedang mengetik, merekam audio, atau mengunggah berkas." : "Suppress typing and recording status so others cannot see when you type or record."), sectionId: self.section)
        case let .silenceNonContacts(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Senyapkan Non-Kontak" : "Silence Non-Contacts", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleSilenceNonContacts(value)
            })
        case .silenceNonContactsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Matikan suara dan getaran notifikasi untuk pesan pribadi dari pengguna yang bukan kontak Anda." : "Silence sounds and vibration for incoming private messages from users not in your contacts."), sectionId: self.section)
        case let .ignoreBlockedInGroups(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tutup Pesan Akun Terblokir di Grup" : "Hide Blocked Messages in Groups", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleIgnoreBlockedInGroups(value)
            })
        case .ignoreBlockedInGroupsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tutup isi pesan dari akun yang Anda blokir di dalam grup obrolan menggunakan efek sensor spoiler." : "Conceal messages from blocked users in group chats using a spoiler overlay."), sectionId: self.section)
        case let .hidePhoneNumber(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Sembunyikan Nomor Telepon" : "Hide Phone Number", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHidePhoneNumber(value)
            })
        case .hidePhoneNumberFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Samarkan nomor telepon di menu Pengaturan dan tampilan header profil." : "Mask your phone number in Settings and Profile headers."), sectionId: self.section)
        case let .askBeforeCall(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Konfirmasi Sebelum Menelepon" : "Ask Before Calling", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleAskBeforeCall(value)
            })
        case .askBeforeCallFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan konfirmasi sebelum memulai panggilan suara atau video agar tidak tertekan tanpa sengaja." : "Show confirmation dialog before initiating voice or video calls to prevent accidental calls."), sectionId: self.section)
        case let .ignoreRestrictions(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Abaikan Pembatasan Konten" : "Ignore Content Restrictions", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleIgnoreContentRestrictions(value)
            })
        case .ignoreRestrictionsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Bypass pembatasan konten regional dan batasan platform Apple pada channel serta grup." : "Bypass regional and Apple platform content restrictions on channels and groups."), sectionId: self.section)
        case let .skipReadHistory(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Jangan Kirim Tanda Baca" : "Do Not Send Read Receipts", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleSkipReadHistory(value)
            })
        case .skipReadHistoryFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Jangan tandai pesan atau cerita sebagai telah dibaca saat membukanya." : "Do not mark messages or stories as read when opening them."), sectionId: self.section)
            
        case .appearanceHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: isId ? "TAMPILAN" : "APPEARANCE", sectionId: self.section)
        case let .formatWithSeconds(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Waktu dengan Detik" : "Time with Seconds", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleFormatWithSeconds(value)
            })
        case .formatWithSecondsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan detik pada cap waktu pesan obrolan (misal 14:25:36)." : "Show seconds in message timestamps (e.g. 14:23:45)."), sectionId: self.section)
        case let .hideStories(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Sembunyikan Bar Cerita" : "Hide Stories Bar", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHideStories(value)
            })
        case .hideStoriesFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Sembunyikan bilah cerita di bagian atas daftar obrolan agar tampilan lebih rapi." : "Hide the stories bar at the top of the chat list for a cleaner view."), sectionId: self.section)
        case let .hideAllChatsTab(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Sembunyikan Tab 'Semua Obrolan'" : "Hide 'All Chats' Tab", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHideAllChatsTab(value)
            })
        case .hideAllChatsTabFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Sembunyikan tab bawaan 'Semua' jika Anda sudah memiliki folder obrolan khusus." : "Hide the default 'All Chats' tab if you have created custom chat folders."), sectionId: self.section)
        case let .disableRounding(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Nonaktifkan Pembulatan Angka" : "Disable Number Rounding", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableNumberRounding(value)
            })
        case .disableRoundingFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan jumlah pelanggan dan penayangan secara eksak tanpa pembulatan (misal 4.777 alih-alih 4.8K)." : "Show exact numbers for views and member counts (e.g. 4777 instead of 4.8K)."), sectionId: self.section)
        case .appIcon:
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Ikon Aplikasi" : "App Icon", label: "", sectionId: self.section, style: .blocks, disclosureStyle: .arrow, action: {
                arguments.openAppIconSettings()
            })
        case .appIconFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Pilih varian ikon aplikasi Nekogram resmi." : "Choose your preferred official Nekogram app icon."), sectionId: self.section)
        case let .disableAppBarShadow(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Nonaktifkan Garis Pemisah Navigasi" : "Disable App Bar Separator", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableAppBarShadow(value)
            })
        case .disableAppBarShadowFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Sembunyikan garis tipis pembatas di bawah bilah navigasi atas." : "Hide the subtle separator line below the top navigation bar."), sectionId: self.section)
        case let .tabTitleType(label):
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Gaya Judul Tab Folder" : "Tabs Title Type", label: label, sectionId: self.section, style: .blocks, action: {
                arguments.openTabTitleTypeMenu()
            })
        case .tabTitleTypeFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Pilih apakah tab folder obrolan menampilkan judul saja, ikon emoji saja, atau keduanya." : "Choose whether folder tabs display titles only, emoji icons only, or both."), sectionId: self.section)
            
        case .chatHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: isId ? "OBROLAN" : "CHAT", sectionId: self.section)
        case let .noQuoteForward(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Teruskan Tanpa Kutipan" : "Forward without Quote", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleNoQuoteForward(value)
            })
        case .noQuoteForwardFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Teruskan pesan secara langsung tanpa mencantumkan nama pengirim asli." : "Automatically forward messages without sender attribution."), sectionId: self.section)
        case let .repeatMessageAction(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Kirim Ulang Pesan di Menu" : "Repeat Message in Menu", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleRepeatMessageAction(value)
            })
        case .repeatMessageActionFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tambahkan opsi Kirim Ulang di menu konteks pesan untuk menduplikasi pesan secara instan." : "Add a Repeat button in the message context menu to instantly duplicate and resend messages."), sectionId: self.section)
        case let .disableGreetingSticker(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Matikan Stiker Sapaan" : "Disable Greeting Sticker", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableGreetingSticker(value)
            })
        case .disableGreetingStickerFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Sembunyikan stiker animasi besar 'Say hello' di ruang obrolan baru yang masih kosong." : "Hide the large 'Say hello' animated sticker in newly opened empty chats."), sectionId: self.section)
        case let .hideTimeOnStickers(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Sembunyikan Jam di Stiker" : "Hide Time on Stickers", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHideTimeOnStickers(value)
            })
        case .hideTimeOnStickersFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Hilangkan tampilan cap waktu di sudut stiker sehingga gambar stiker tampil bersih." : "Hide the timestamp overlay on stickers for a clean, unobstructed appearance."), sectionId: self.section)
        case let .disableJumpToNextChannel(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Nonaktifkan Lompat ke Channel Lain" : "Disable Jump to Next Channel", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableJumpToNextChannel(value)
            })
        case .disableJumpToNextChannelFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Cegah peralihan otomatis ke channel belum dibaca berikutnya saat menggulir melewati pesan terakhir." : "Prevent automatically switching to the next unread channel when scrolling past the last message."), sectionId: self.section)
        case let .confirmSendVoice(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Konfirmasi Kirim Suara / Video" : "Confirm Send Voice / Video", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleConfirmSendVoice(value)
            })
        case .confirmSendVoiceFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Minta konfirmasi sebelum mengirimkan pesan rekaman suara atau video bulat." : "Ask for confirmation before sending recorded voice or video notes."), sectionId: self.section)
        case let .confirmSendSticker(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Konfirmasi Kirim Stiker" : "Confirm Send Sticker", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleConfirmSendSticker(value)
            })
        case .confirmSendStickerFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Minta konfirmasi sebelum mengirimkan stiker untuk menghindari ketukan tidak sengaja." : "Ask for confirmation before sending a sticker to avoid accidental taps."), sectionId: self.section)
        case let .dismissKeyboardOnScroll(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tutup Keyboard Saat Menggulir" : "Dismiss Keyboard on Scroll", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDismissKeyboardOnScroll(value)
            })
        case .dismissKeyboardOnScrollFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tutup papan ketik otomatis saat Anda menggeser atau menggulir riwayat obrolan." : "Automatically dismiss keyboard when scrolling through chat history."), sectionId: self.section)
        case let .expandRecentStickers(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Perluas Riwayat Stiker (100 Item)" : "Expand Recent Stickers (100)", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleExpandRecentStickers(value)
            })
        case .expandRecentStickersFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Simpan hingga 100 stiker terbaru di panel stiker alih-alih batas default 20." : "Store up to 100 recent stickers in the keyboard panel instead of the default 20."), sectionId: self.section)
        case let .disableProximitySensor(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Nonaktifkan Sensor Jarak" : "Disable Proximity Sensor", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableProximitySensor(value)
            })
        case .disableProximitySensorFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Layar tidak akan mati dan suara tidak beralih ke earpiece saat sensor atas tertutup sewaktu memutar audio." : "Prevent screen from turning off and audio switching to earpiece when proximity sensor is covered."), sectionId: self.section)
        case let .showMessageDetails(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Detail Pesan di Menu" : "Message Details in Menu", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowMessageDetails(value)
            })
        case .showMessageDetailsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tambahkan opsi Detail Pesan di menu pesan untuk melihat ID pesan, tanggal lengkap, dan info teknis." : "Add Message Details option to message context menu showing ID, timestamp, and peer info."), sectionId: self.section)
        case let .doubleTapAction(title):
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Aksi Ketuk Dua Kali" : "Double Tap Action", label: title, sectionId: self.section, style: .blocks, action: {
                arguments.openDoubleTapAction()
            })
        case .doubleTapActionFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Pilih tindakan yang dilakukan saat mengetuk dua kali balon pesan." : "Choose the action performed when double tapping a message bubble."), sectionId: self.section)
        case let .defaultMarkdown(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Format Markdown Otomatis" : "Markdown by Default", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDefaultMarkdown(value)
            })
        case .defaultMarkdownFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Otomatis format **tebal**, __miring__, dan `kode` saat mengirim pesan." : "Automatically format **bold**, __italic__, and `code` when sending messages."), sectionId: self.section)
        case let .downloadSpeedBoost(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Akselerasi Unduhan" : "Download Speed Boost", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDownloadSpeedBoost(value)
            })
        case .downloadSpeedBoostFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Percepat unduhan media dan berkas besar dengan melipatgandakan koneksi paralel MTProto." : "Accelerate media and large file downloads by doubling parallel MTProto chunk connections."), sectionId: self.section)
        case let .toastRpcErrors(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tampilkan Galat RPC" : "Toast on RPC Errors", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleToastRpcErrors(value)
            })
        case .toastRpcErrorsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan notifikasi toast saat permintaan API Telegram mengembalikan galat MTProto (misal FLOOD_WAIT)." : "Display toast notifications when Telegram API requests return MTProto RPC errors (e.g. FLOOD_WAIT)."), sectionId: self.section)
        case let .disableVoiceMessageAutoPlay(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Nonaktifkan Putar Otomatis Pesan Suara" : "Disable Voice Message Auto-play", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleDisableVoiceMessageAutoPlay(value)
            })
        case .disableVoiceMessageAutoPlayFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Hentikan pemutaran berantai otomatis untuk pesan suara berikutnya." : "Do not automatically play the next voice note in chat."), sectionId: self.section)
        case let .showQrCode(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tampilkan Kode QR di Pesan" : "Show QR Code on Messages", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowQrCode(value)
            })
        case .showQrCodeFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan aksi pembuatan kode QR di menu konteks pesan teks atau tautan." : "Show a QR code generator action in the message context menu."), sectionId: self.section)
        case let .showPrPr(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Tampilkan Aksi Colek (Peropero)" : "Show Peropero (prpr) Action", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleShowPrPr(value)
            })
        case .showPrPrFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan tombol colek cepat /prpr di menu konteks pesan anggota lain." : "Show quick /prpr mention action in the message context menu."), sectionId: self.section)
        case let .hideChannelBottomButtons(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Sembunyikan Tombol Bawah Saluran" : "Hide Channel Bottom Buttons", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleHideChannelBottomButtons(value)
            })
        case .hideChannelBottomButtonsFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Sembunyikan panel bisukan/diskusi di bagian bawah saluran siaran." : "Hide the mute/discuss bar at the bottom of broadcast channels."), sectionId: self.section)
        case let .tryOpenInstantView(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Coba Buka Semua Tautan di Instant View" : "Try Open All Links in Instant View", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleTryOpenInstantView(value)
            })
        case .tryOpenInstantViewFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Otomatis mencoba merender pratinjau Instant View untuk setiap tautan web eksternal sebelum membuka browser." : "Attempt to load Telegram Instant View for all external web links before opening in browser."), sectionId: self.section)
        case let .translationProvider(label):
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Penyedia Terjemahan Pesan" : "Translation Provider", label: label, sectionId: self.section, style: .blocks, action: {
                arguments.openTranslationProviderMenu()
            })
        case .translationProviderFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Pilih mesin terjemahan saat menggunakan tombol Terjemahkan pada menu pesan (Bawaan Telegram, Google Translate, atau DeepL)." : "Choose translation engine for the message context menu (Built-in Telegram, Google Translate, or DeepL)."), sectionId: self.section)
        case let .miniSenderAvatar(value):
            return ItemListSwitchItem(presentationData: presentationData, title: isId ? "Avatar Mini Pengirim di Daftar Chat" : "Mini Sender Avatar in Chat List", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.toggleMiniSenderAvatar(value)
            })
        case .miniSenderAvatarFooter:
            return ItemListTextItem(presentationData: presentationData, text: .plain(isId ? "Tampilkan foto profil kecil di sebelah nama pengirim pesan terakhir pada obrolan grup di daftar chat." : "Display a miniature sender avatar next to the author name in group dialogs."), sectionId: self.section)
            
        case .aboutHeader:
            return ItemListSectionHeaderItem(presentationData: presentationData, text: isId ? "TENTANG" : "ABOUT", sectionId: self.section)
        case let .aboutVersion(version):
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Versi Aplikasi" : "App Version", label: version, sectionId: self.section, style: .blocks, disclosureStyle: .none, action: nil)
        case let .aboutUpstream(upstream):
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Basis Upstream" : "Upstream Base", label: upstream, sectionId: self.section, style: .blocks, disclosureStyle: .none, action: nil)
        case .aboutSourceCode:
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Kode Sumber" : "Source Code", label: "GitHub", sectionId: self.section, style: .blocks, disclosureStyle: .arrow, action: {
                arguments.openUrl("https://github.com/jimbon25/nekogram-ios")
            })
        case .aboutInspiration:
            return ItemListDisclosureItem(presentationData: presentationData, title: isId ? "Inspirasi Upstream" : "Upstream Inspiration", label: "Nekogram (Android)", sectionId: self.section, style: .blocks, disclosureStyle: .arrow, action: {
                arguments.openUrl("https://github.com/Nekogram/Nekogram")
            })
        case .aboutFooter:
            let footerText = isId ?
                "Port tidak resmi untuk iOS. Dioptimasi untuk privasi, performa, dan kenyamanan. Tidak berafiliasi dengan Telegram FZ-LLC." :
                "Unofficial port for iOS. Optimized for privacy, performance, and convenience. Not affiliated with Telegram FZ-LLC."
            return ItemListTextItem(presentationData: presentationData, text: .plain(footerText), sectionId: self.section)
        }
    }
}

private func nekoSettingsControllerEntries(presentationData: PresentationData, state: NekoSettingsState) -> [NekoSettingsControllerEntry] {
    var entries: [NekoSettingsControllerEntry] = []
    let isId = presentationData.strings.primaryComponent.languageCode == "id"
    
    entries.append(.generalHeader)
    entries.append(.nameOrder(presentationData.nameDisplayOrder))
    entries.append(.nameOrderFooter)
    entries.append(.showIdAndDc(state.showIdAndDc))
    entries.append(.showIdAndDcFooter)
    if state.showIdAndDc {
        entries.append(.chatIdFormatBotApi(state.chatIdFormatBotApi))
        entries.append(.chatIdFormatBotApiFooter)
    }
    
    entries.append(.privacyHeader)
    entries.append(.suppressTyping(state.suppressTyping))
    entries.append(.suppressTypingFooter)
    entries.append(.silenceNonContacts(state.silenceNonContacts))
    entries.append(.silenceNonContactsFooter)
    entries.append(.ignoreBlockedInGroups(state.ignoreBlockedInGroups))
    entries.append(.ignoreBlockedInGroupsFooter)
    entries.append(.hidePhoneNumber(state.hidePhoneNumber))
    entries.append(.hidePhoneNumberFooter)
    entries.append(.askBeforeCall(state.askBeforeCall))
    entries.append(.askBeforeCallFooter)
    entries.append(.ignoreRestrictions(state.ignoreContentRestrictions))
    entries.append(.ignoreRestrictionsFooter)
    entries.append(.skipReadHistory(state.skipReadHistory))
    entries.append(.skipReadHistoryFooter)
    
    entries.append(.appearanceHeader)
    entries.append(.formatWithSeconds(state.formatTimeWithSeconds))
    entries.append(.formatWithSecondsFooter)
    entries.append(.hideStories(state.hideStories))
    entries.append(.hideStoriesFooter)
    entries.append(.hideAllChatsTab(state.hideAllChatsTab))
    entries.append(.hideAllChatsTabFooter)
    entries.append(.disableRounding(state.disableNumberRounding))
    entries.append(.disableRoundingFooter)
    entries.append(.appIcon)
    entries.append(.appIconFooter)
    entries.append(.disableAppBarShadow(state.disableAppBarShadow))
    entries.append(.disableAppBarShadowFooter)
    
    let tabTitleTypeLabel: String
    if isId {
        switch state.tabTitleType {
        case 1: tabTitleTypeLabel = "Ikon Saja"
        case 2: tabTitleTypeLabel = "Ikon dan Judul"
        default: tabTitleTypeLabel = "Judul Saja"
        }
    } else {
        switch state.tabTitleType {
        case 1: tabTitleTypeLabel = "Icons Only"
        case 2: tabTitleTypeLabel = "Icons and Titles"
        default: tabTitleTypeLabel = "Titles Only"
        }
    }
    entries.append(.tabTitleType(tabTitleTypeLabel))
    entries.append(.tabTitleTypeFooter)
    
    entries.append(.chatHeader)
    entries.append(.noQuoteForward(state.noQuoteForward))
    entries.append(.noQuoteForwardFooter)
    entries.append(.repeatMessageAction(state.repeatMessageAction))
    entries.append(.repeatMessageActionFooter)
    entries.append(.disableGreetingSticker(state.disableGreetingSticker))
    entries.append(.disableGreetingStickerFooter)
    entries.append(.hideTimeOnStickers(state.hideTimeOnStickers))
    entries.append(.hideTimeOnStickersFooter)
    entries.append(.disableJumpToNextChannel(state.disableJumpToNextChannel))
    entries.append(.disableJumpToNextChannelFooter)
    entries.append(.confirmSendVoice(state.confirmSendVoice))
    entries.append(.confirmSendVoiceFooter)
    entries.append(.confirmSendSticker(state.confirmSendSticker))
    entries.append(.confirmSendStickerFooter)
    entries.append(.dismissKeyboardOnScroll(state.dismissKeyboardOnScroll))
    entries.append(.dismissKeyboardOnScrollFooter)
    entries.append(.expandRecentStickers(state.expandRecentStickers))
    entries.append(.expandRecentStickersFooter)
    entries.append(.disableProximitySensor(state.disableProximitySensor))
    entries.append(.disableProximitySensorFooter)
    entries.append(.showMessageDetails(state.showMessageDetails))
    entries.append(.showMessageDetailsFooter)
    
    let doubleTapLabel: String
    if isId {
        switch state.doubleTapAction {
        case .reaction: doubleTapLabel = "Reaksi Cepat"
        case .reply: doubleTapLabel = "Balas Pesan"
        case .copy: doubleTapLabel = "Salin Teks"
        case .disabled: doubleTapLabel = "Nonaktif"
        }
    } else {
        doubleTapLabel = state.doubleTapAction.title
    }
    entries.append(.doubleTapAction(doubleTapLabel))
    entries.append(.doubleTapActionFooter)
    entries.append(.defaultMarkdown(state.defaultMarkdown))
    entries.append(.defaultMarkdownFooter)
    entries.append(.downloadSpeedBoost(state.downloadSpeedBoost))
    entries.append(.downloadSpeedBoostFooter)
    entries.append(.toastRpcErrors(state.toastRpcErrors))
    entries.append(.toastRpcErrorsFooter)
    entries.append(.disableVoiceMessageAutoPlay(state.disableVoiceMessageAutoPlay))
    entries.append(.disableVoiceMessageAutoPlayFooter)
    entries.append(.showQrCode(state.showQrCode))
    entries.append(.showQrCodeFooter)
    entries.append(.showPrPr(state.showPrPr))
    entries.append(.showPrPrFooter)
    entries.append(.hideChannelBottomButtons(state.hideChannelBottomButtons))
    entries.append(.hideChannelBottomButtonsFooter)
    entries.append(.tryOpenInstantView(state.tryOpenInstantView))
    entries.append(.tryOpenInstantViewFooter)
    
    let translationProviderLabel: String
    if isId {
        switch state.translationProvider {
        case 1: translationProviderLabel = "Google Translate"
        case 2: translationProviderLabel = "DeepL"
        default: translationProviderLabel = "Bawaan Telegram"
        }
    } else {
        switch state.translationProvider {
        case 1: translationProviderLabel = "Google Translate"
        case 2: translationProviderLabel = "DeepL"
        default: translationProviderLabel = "Telegram Built-in"
        }
    }
    entries.append(.translationProvider(translationProviderLabel))
    entries.append(.translationProviderFooter)
    entries.append(.miniSenderAvatar(state.miniSenderAvatar))
    entries.append(.miniSenderAvatarFooter)
    
    let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "13.0"
    let buildNumber = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
    let versionLabel = buildNumber.isEmpty ? appVersion : "\(appVersion) (\(buildNumber))"
    
    entries.append(.aboutHeader)
    entries.append(.aboutVersion(versionLabel))
    entries.append(.aboutUpstream("Telegram iOS"))
    entries.append(.aboutSourceCode)
    entries.append(.aboutInspiration)
    entries.append(.aboutFooter)
    
    return entries
}

public func nekoSettingsController(context: AccountContext) -> ViewController {
    let statePromise = ValuePromise(NekoSettingsState(), ignoreRepeated: true)
    
    var presentControllerImpl: ((ViewController, Any?) -> Void)?
    var pushControllerImpl: ((ViewController) -> Void)?
    
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
        toggleSuppressTyping: { value in
            NekoSettings.shared.suppressTyping = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableProximitySensor: { value in
            NekoSettings.shared.disableProximitySensor = value
            statePromise.set(NekoSettingsState())
        },
        toggleExpandRecentStickers: { value in
            NekoSettings.shared.expandRecentStickers = value
            statePromise.set(NekoSettingsState())
        },
        toggleDismissKeyboardOnScroll: { value in
            NekoSettings.shared.dismissKeyboardOnScroll = value
            statePromise.set(NekoSettingsState())
        },
        toggleHideAllChatsTab: { value in
            NekoSettings.shared.hideAllChatsTab = value
            statePromise.set(NekoSettingsState())
        },
        toggleSilenceNonContacts: { value in
            NekoSettings.shared.silenceNonContacts = value
            statePromise.set(NekoSettingsState())
        },
        toggleIgnoreBlockedInGroups: { value in
            NekoSettings.shared.ignoreBlockedInGroups = value
            statePromise.set(NekoSettingsState())
        },
        toggleChatIdFormatBotApi: { value in
            NekoSettings.shared.chatIdFormatBotApi = value
            statePromise.set(NekoSettingsState())
        },
        toggleRepeatMessageAction: { value in
            NekoSettings.shared.repeatMessageAction = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableGreetingSticker: { value in
            NekoSettings.shared.disableGreetingSticker = value
            statePromise.set(NekoSettingsState())
        },
        toggleHideTimeOnStickers: { value in
            NekoSettings.shared.hideTimeOnStickers = value
            statePromise.set(NekoSettingsState())
        },
        toggleDownloadSpeedBoost: { value in
            NekoSettings.shared.downloadSpeedBoost = value
            statePromise.set(NekoSettingsState())
        },
        toggleToastRpcErrors: { value in
            NekoSettings.shared.toastRpcErrors = value
            statePromise.set(NekoSettingsState())
        },
        toggleDefaultMarkdown: { value in
            NekoSettings.shared.defaultMarkdown = value
            statePromise.set(NekoSettingsState())
        },
        toggleSkipReadHistory: { value in
            NekoSettings.shared.skipReadHistory = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableVoiceMessageAutoPlay: { value in
            NekoSettings.shared.disableVoiceMessageAutoPlay = value
            statePromise.set(NekoSettingsState())
        },
        toggleShowQrCode: { value in
            NekoSettings.shared.showQrCode = value
            statePromise.set(NekoSettingsState())
        },
        toggleDisableAppBarShadow: { value in
            NekoSettings.shared.disableAppBarShadow = value
            statePromise.set(NekoSettingsState())
        },
        toggleShowPrPr: { value in
            NekoSettings.shared.showPrPr = value
            statePromise.set(NekoSettingsState())
        },
        toggleHideChannelBottomButtons: { value in
            NekoSettings.shared.hideChannelBottomButtons = value
            statePromise.set(NekoSettingsState())
        },
        toggleTryOpenInstantView: { value in
            NekoSettings.shared.tryOpenInstantView = value
            statePromise.set(NekoSettingsState())
        },
        openTabTitleTypeMenu: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let isId = presentationData.strings.primaryComponent.languageCode == "id"
            let actionSheet = ActionSheetController(presentationData: presentationData)
            let items: [ActionSheetItem] = [
                ActionSheetButtonItem(title: isId ? "Judul Saja" : "Titles Only", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.tabTitleType = 0
                    statePromise.set(NekoSettingsState())
                }),
                ActionSheetButtonItem(title: isId ? "Ikon Saja" : "Icons Only", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.tabTitleType = 1
                    statePromise.set(NekoSettingsState())
                }),
                ActionSheetButtonItem(title: isId ? "Ikon dan Judul" : "Icons and Titles", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.tabTitleType = 2
                    statePromise.set(NekoSettingsState())
                })
            ]
            actionSheet.setItemGroups([
                ActionSheetItemGroup(items: items),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, color: .accent, font: .bold, action: { [weak actionSheet] in
                        actionSheet?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(actionSheet, nil)
        },
        openTranslationProviderMenu: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let isId = presentationData.strings.primaryComponent.languageCode == "id"
            let actionSheet = ActionSheetController(presentationData: presentationData)
            let items: [ActionSheetItem] = [
                ActionSheetButtonItem(title: isId ? "Bawaan Telegram" : "Telegram Built-in", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.translationProvider = 0
                    statePromise.set(NekoSettingsState())
                }),
                ActionSheetButtonItem(title: "Google Translate", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.translationProvider = 1
                    statePromise.set(NekoSettingsState())
                }),
                ActionSheetButtonItem(title: "DeepL", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    NekoSettings.shared.translationProvider = 2
                    statePromise.set(NekoSettingsState())
                })
            ]
            actionSheet.setItemGroups([
                ActionSheetItemGroup(items: items),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, color: .accent, font: .bold, action: { [weak actionSheet] in
                        actionSheet?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(actionSheet, nil)
        },
        toggleMiniSenderAvatar: { value in
            NekoSettings.shared.miniSenderAvatar = value
            statePromise.set(NekoSettingsState())
        },
        openNameOrderMenu: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let isId = presentationData.strings.primaryComponent.languageCode == "id"
            let actionSheet = ActionSheetController(presentationData: presentationData)
            let items: [ActionSheetItem] = [
                ActionSheetButtonItem(title: isId ? "Nama Depan Belakang (First Last)" : "First Last", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    let _ = updateContactSettingsInteractively(accountManager: context.sharedContext.accountManager, { current -> ContactSynchronizationSettings in
                        var updated = current
                        updated.nameDisplayOrder = .firstLast
                        return updated
                    }).start()
                }),
                ActionSheetButtonItem(title: isId ? "Nama Belakang Depan (Last First)" : "Last First", color: .accent, action: { [weak actionSheet] in
                    actionSheet?.dismissAnimated()
                    let _ = updateContactSettingsInteractively(accountManager: context.sharedContext.accountManager, { current -> ContactSynchronizationSettings in
                        var updated = current
                        updated.nameDisplayOrder = .lastFirst
                        return updated
                    }).start()
                })
            ]
            actionSheet.setItemGroups([
                ActionSheetItemGroup(items: items),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, color: .accent, font: .bold, action: { [weak actionSheet] in
                        actionSheet?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(actionSheet, nil)
        },
        openDoubleTapAction: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let isId = presentationData.strings.primaryComponent.languageCode == "id"
            let actionSheet = ActionSheetController(presentationData: presentationData)
            var items: [ActionSheetItem] = []
            for action in NekoDoubleTapAction.allCases {
                let actionTitle: String
                if isId {
                    switch action {
                    case .reaction: actionTitle = "Reaksi Cepat"
                    case .reply: actionTitle = "Balas Pesan"
                    case .copy: actionTitle = "Salin Teks"
                    case .disabled: actionTitle = "Nonaktif"
                    }
                } else {
                    actionTitle = action.title
                }
                items.append(ActionSheetButtonItem(title: actionTitle, color: .accent, action: { [weak actionSheet] in
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
        },
        openAppIconSettings: {
            pushControllerImpl?(themeSettingsController(context: context, focusOnItemTag: ThemeSettingsEntryTag.icon))
        },
        openUrl: { url in
            context.sharedContext.applicationBindings.openUrl(url)
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
        let isId = presentationData.strings.primaryComponent.languageCode == "id"
        
        let controllerState = ItemListControllerState(
            presentationData: ItemListPresentationData(presentationData),
            title: .text(isId ? "Pengaturan Nekogram" : "Nekogram Settings"),
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
    pushControllerImpl = { [weak controller] c in
        controller?.push(c)
    }
    
    return controller
}
