import Foundation

public enum NekoDoubleTapAction: Int32, CaseIterable {
    case reaction = 0
    case reply = 1
    case copy = 2
    case disabled = 3
    
    public var title: String {
        switch self {
        case .reaction:
            return "Quick Reaction"
        case .reply:
            return "Reply"
        case .copy:
            return "Copy Text"
        case .disabled:
            return "Disabled"
        }
    }
}

public final class NekoSettings {
    public static let shared = NekoSettings()
    
    private let defaults = UserDefaults.standard
    
    public static let formatTimeWithSecondsKey = "neko_format_time_with_seconds"
    public static let hidePhoneNumberKey = "neko_hide_phone_number"
    public static let ignoreContentRestrictionsKey = "neko_ignore_content_restrictions"
    public static let disableNumberRoundingKey = "neko_disable_number_rounding"
    public static let doubleTapActionKey = "neko_double_tap_action"
    public static let confirmSendStickerKey = "neko_confirm_send_sticker"
    public static let hideStoriesKey = "neko_hide_stories"
    public static let noQuoteForwardKey = "neko_no_quote_forward"
    public static let showIdAndDcKey = "neko_show_id_and_dc"
    public static let disableJumpToNextChannelKey = "neko_disable_jump_to_next_channel"
    public static let askBeforeCallKey = "neko_ask_before_calling"
    public static let confirmSendVoiceKey = "neko_confirm_send_voice"
    public static let showMessageDetailsKey = "neko_show_message_details"
    public static let suppressTypingKey = "neko_suppress_typing"
    public static let disableProximitySensorKey = "neko_disable_proximity_sensor"
    public static let expandRecentStickersKey = "neko_expand_recent_stickers"
    public static let dismissKeyboardOnScrollKey = "neko_dismiss_keyboard_on_scroll"
    public static let hideAllChatsTabKey = "neko_hide_all_chats_tab"
    public static let silenceNonContactsKey = "neko_silence_non_contacts"
    public static let ignoreBlockedInGroupsKey = "neko_ignore_blocked_in_groups"
    public static let blockedPeerIdsKey = "neko_blocked_peer_ids"
    public static let disableGreetingStickerKey = "neko_disable_greeting_sticker"
    public static let hideTimeOnStickersKey = "neko_hide_time_on_stickers"
    public static let chatIdFormatBotApiKey = "neko_chat_id_format_bot_api"
    public static let repeatMessageActionKey = "neko_repeat_message_action"
    
    public var formatTimeWithSeconds: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.formatTimeWithSecondsKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.formatTimeWithSecondsKey)
        }
    }
    
    public var hidePhoneNumber: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.hidePhoneNumberKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.hidePhoneNumberKey)
        }
    }
    
    public var ignoreContentRestrictions: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.ignoreContentRestrictionsKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.ignoreContentRestrictionsKey)
        }
    }
    
    public var disableNumberRounding: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.disableNumberRoundingKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.disableNumberRoundingKey)
        }
    }
    
    public var doubleTapAction: NekoDoubleTapAction {
        get {
            let val = Int32(self.defaults.integer(forKey: NekoSettings.doubleTapActionKey))
            return NekoDoubleTapAction(rawValue: val) ?? .reaction
        }
        set {
            self.defaults.set(Int(newValue.rawValue), forKey: NekoSettings.doubleTapActionKey)
        }
    }
    
    public var confirmSendSticker: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.confirmSendStickerKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.confirmSendStickerKey)
        }
    }
    
    public var hideStories: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.hideStoriesKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.hideStoriesKey)
        }
    }
    
    public var noQuoteForward: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.noQuoteForwardKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.noQuoteForwardKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.noQuoteForwardKey)
        }
    }
    
    public var showIdAndDc: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.showIdAndDcKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.showIdAndDcKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.showIdAndDcKey)
        }
    }
    
    public var disableJumpToNextChannel: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.disableJumpToNextChannelKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.disableJumpToNextChannelKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.disableJumpToNextChannelKey)
        }
    }
    
    public var askBeforeCall: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.askBeforeCallKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.askBeforeCallKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.askBeforeCallKey)
        }
    }
    
    public var confirmSendVoice: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.confirmSendVoiceKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.confirmSendVoiceKey)
        }
    }
    
    public var showMessageDetails: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.showMessageDetailsKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.showMessageDetailsKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.showMessageDetailsKey)
        }
    }
    
    public var suppressTyping: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.suppressTypingKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.suppressTypingKey)
        }
    }
    
    public var disableProximitySensor: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.disableProximitySensorKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.disableProximitySensorKey)
        }
    }
    
    public var expandRecentStickers: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.expandRecentStickersKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.expandRecentStickersKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.expandRecentStickersKey)
        }
    }
    
    public var dismissKeyboardOnScroll: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.dismissKeyboardOnScrollKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.dismissKeyboardOnScrollKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.dismissKeyboardOnScrollKey)
        }
    }
    
    public var hideAllChatsTab: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.hideAllChatsTabKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.hideAllChatsTabKey)
        }
    }
    
    public var silenceNonContacts: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.silenceNonContactsKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.silenceNonContactsKey)
        }
    }
    
    public var ignoreBlockedInGroups: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.ignoreBlockedInGroupsKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.ignoreBlockedInGroupsKey)
        }
    }
    
    public var blockedPeerIds: Set<Int64> {
        get {
            if let array = self.defaults.array(forKey: NekoSettings.blockedPeerIdsKey) as? [NSNumber] {
                return Set(array.map { $0.int64Value })
            }
            return []
        }
        set {
            let numbers = newValue.map { NSNumber(value: $0) }
            self.defaults.set(numbers, forKey: NekoSettings.blockedPeerIdsKey)
        }
    }
    
    public func isPeerBlocked(_ id: Int64) -> Bool {
        return self.blockedPeerIds.contains(id)
    }
    
    public func addBlockedPeerId(_ id: Int64) {
        var current = self.blockedPeerIds
        current.insert(id)
        self.blockedPeerIds = current
    }
    
    public func removeBlockedPeerId(_ id: Int64) {
        var current = self.blockedPeerIds
        current.remove(id)
        self.blockedPeerIds = current
    }
    
    public var disableGreetingSticker: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.disableGreetingStickerKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.disableGreetingStickerKey)
        }
    }
    
    public var hideTimeOnStickers: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.hideTimeOnStickersKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.hideTimeOnStickersKey)
        }
    }
    
    public var chatIdFormatBotApi: Bool {
        get {
            return self.defaults.bool(forKey: NekoSettings.chatIdFormatBotApiKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.chatIdFormatBotApiKey)
        }
    }
    
    public var repeatMessageAction: Bool {
        get {
            if self.defaults.object(forKey: NekoSettings.repeatMessageActionKey) == nil {
                return true
            }
            return self.defaults.bool(forKey: NekoSettings.repeatMessageActionKey)
        }
        set {
            self.defaults.set(newValue, forKey: NekoSettings.repeatMessageActionKey)
        }
    }
}
