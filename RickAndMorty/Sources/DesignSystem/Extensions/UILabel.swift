import UIKit

extension UILabel {
    static func build(type: Typography, text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = type.font
        label.text = text
        label.textColor = color
        return label
    }
}
