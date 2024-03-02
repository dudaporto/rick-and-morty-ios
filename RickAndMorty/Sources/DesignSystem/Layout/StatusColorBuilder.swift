import class UIKit.UIColor

enum StatusColorBuilder {
    static func getColor(for status: CharacterListResponse.Character.Status) -> UIColor {
        switch status {
        case .alive: return Color.green0.color
        case .dead: return Color.red0.color
        case .unknown: return Color.gray1.color
        }
    }
}
