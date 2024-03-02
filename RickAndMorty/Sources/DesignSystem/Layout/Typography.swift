import UIKit

fileprivate enum FontName {
    static let bold = "SF Pro Display Bold"
    static let regular = "SF Pro Display Regular"
}

enum Typography {
    /// Bold 34
    case largeTitle
    /// Bold 22
    case highlightTitle
    /// Bold 18
    case highlightSecondaryTitle
    /// Bold 14
    case highlightTertiaryTitle
    /// Regular 18
    case title
    /// Regular 16
    case subtitle
    /// Regular 14
    case caption

    var font: UIFont? {
        let font: UIFont?
        switch self {
        case .largeTitle:
            font = UIFont(name: FontName.bold, size: 34)
        case .highlightTitle:
            font = UIFont(name: FontName.bold, size: 22)
        case .highlightSecondaryTitle:
            font = UIFont(name: FontName.bold, size: 18)
        case .highlightTertiaryTitle:
            font = UIFont(name: FontName.bold, size: 14)
        case .title:
            font = UIFont(name: FontName.regular, size: 18)
        case .subtitle:
            font = UIFont(name: FontName.regular, size: 16)
        case .caption:
            font = UIFont(name: FontName.regular, size: 14)
        }
        return font
    }
}
