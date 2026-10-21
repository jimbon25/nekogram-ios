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
}
