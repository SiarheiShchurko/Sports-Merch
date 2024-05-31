import UIKit
final class RchUniqueStackRtoViewSor: UIStackView {
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     alignment: UIStackView.Alignment,
                     distribution: UIStackView.Distribution = .equalCentering,
                     spacing: CGFloat = 0,
                     backgroundColor: UIColor = .clear,
                     cornerRadius: CGFloat = 0) {
        self.init(arrangedSubviews: views)
        configure(axis: axis, alignment: alignment, distribution: distribution, spacing: spacing, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
}

// MARK: - Private extension
private extension RchUniqueStackRtoViewSor {
    func configure(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat, backgroundColor: UIColor, cornerRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        if spacing > 0 {
            self.spacing = spacing
        }
    }
}
