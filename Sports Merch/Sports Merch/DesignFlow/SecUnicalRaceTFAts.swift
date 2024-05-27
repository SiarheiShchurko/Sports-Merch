import UIKit
final class SecUnicalRaceTFAts: UITextField {
    let backgroundColors: UIColor
    private let isCanPerformAction: Bool
    init(placeholder: String = "",
         text: String = "",
         tintColor: UIColor = .black,
         backgroundColor: UIColor = .white,
         placeholderColor: UIColor = .black.withAlphaComponent(0.4),
         keyboardType: UIKeyboardType = .default,
         verticalAlign: ContentVerticalAlignment = .center,
         isCanPerformAction: Bool = true) {
        self.isCanPerformAction = isCanPerformAction
        self.backgroundColors = backgroundColor
        super.init(frame: .zero)
        settingTextField(placeholdere: placeholder,
                         text: text,
                         verticalAlign: verticalAlign,
                         keyboardType: keyboardType,
                         placeholderColor: placeholderColor,
                         tintColor: tintColor,
                         backgroundColor: backgroundColor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if !isCanPerformAction,
           action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = backgroundColors
            } else {
                backgroundColor = .gray
            }
        }
    }
}
private extension SecUnicalRaceTFAts {
    private func settingTextField(placeholdere: String,
                                  text: String,
                                  verticalAlign: ContentVerticalAlignment,
                                  keyboardType: UIKeyboardType,
                                  placeholderColor: UIColor,
                                  tintColor: UIColor,
                                  backgroundColor: UIColor) {
        indent(size: 16)
        attributedPlaceholder = NSAttributedString(string: placeholdere,
                                                   attributes: [NSAttributedString.Key.foregroundColor: placeholderColor, .font: UIFont.systemFont(ofSize: 17)])
        translatesAutoresizingMaskIntoConstraints = false
        self.keyboardType = keyboardType
        self.backgroundColor = backgroundColor
        self.text = text
        textColor = tintColor
        clearButtonMode = .whileEditing
        font = .boldSystemFont(ofSize: 17)
        contentVerticalAlignment = verticalAlign
    }
}
extension SecUnicalRaceTFAts {
    func indent(size: CGFloat) {
        leftView = UIView(frame: CGRect(x: frame.minX, y: frame.minY, width: size, height: frame.height))
        leftViewMode = .always
    }
}

func setGtv(with horizontDta: String) -> Bool {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "dd.MM.yyyy"
    guard let date = dateformatter.date(from: horizontDta) else {
        return false
    }
   return Date().timeIntervalSince1970 > date.timeIntervalSince1970 ? true : false
}
