import UIKit

extension UIView {
    func fitToParent(with insets: UIEdgeInsets = .zero) {
        guard let parent = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ])
    }
    
    func size(_ size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size),
            widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func height(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
