import UIKit

final class SecTemplRaceTextViewAts: UITextView {
    convenience init(
        text: String,
        font: UIFont = .systemFont(ofSize: 15),
        isCanEdit: Bool = false) {
            self.init(frame: .zero)
            setTextView(text: text, font: font, isCanEdit: isCanEdit)
        }
}

private extension SecTemplRaceTextViewAts {
    func setTextView(text: String, font: UIFont, isCanEdit: Bool ) {
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        textColor = .white.withAlphaComponent(0.8)
        backgroundColor = .appMainBckgrd
        isEditable = isCanEdit
        layer.cornerRadius = 16
    }
}
