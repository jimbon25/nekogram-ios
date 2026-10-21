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
}
