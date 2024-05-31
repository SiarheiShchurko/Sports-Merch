import UIKit
extension UILabel {
    func setRchLabelTopTextSor(firstLine: String,
                     secondLine: String,
                     firstLineFontSize: CGFloat = 20,
                     secondLineFontSize: CGFloat = 13,
                     firstLineTextColor: UIColor = UIColor.white,
                     secondLineTextColor: UIColor = UIColor.black.withAlphaComponent(0.6)) {
        let firstLineAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: firstLineFontSize),
            .foregroundColor: firstLineTextColor
        ]
        let firstLineAttributedString = NSAttributedString(string: firstLine, attributes: firstLineAttributes)
        let secondLineAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: secondLineFontSize),
            .foregroundColor: secondLineTextColor
        ]
        let secondLineAttributedString = NSAttributedString(string: "\n\(secondLine)", attributes: secondLineAttributes)
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(firstLineAttributedString)
        fullAttributedString.append(secondLineAttributedString)
        self.attributedText = fullAttributedString
    }
}
