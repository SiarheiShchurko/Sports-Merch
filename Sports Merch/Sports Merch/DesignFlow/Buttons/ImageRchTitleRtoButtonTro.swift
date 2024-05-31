import UIKit
class ImageRchTitleRtoButtonTro: UIButton {
    enum ButtonImageLeading {
        case top
        case leading
    }
    
     init(titleButton: String?,
         colorButton: UIColor?,
         fontButton: UIFont?,
         textColorButton: UIColor = .appPrimaryColor,
         buttonImage: UIImage = UIImage(),
         imageLeading: ButtonImageLeading = .leading,
                     cornerRadius: CGFloat = 0.0) {
         super.init(frame: .zero)
        setButton(titleButton: titleButton, colorButton: colorButton, fontButton: fontButton, textColorButton: textColorButton, buttonImage: buttonImage, cornerRadius: cornerRadius)
        imageLeading == .top ? topImageConstraints() : ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2.0
            } else {
                layer.borderWidth = 0.0
            }
        }
    }
}
private extension ImageRchTitleRtoButtonTro {
    private func setButton(titleButton: String?, colorButton: UIColor?, fontButton: UIFont?, textColorButton: UIColor?, buttonImage: UIImage, cornerRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = true
        setTitle(titleButton, for: .normal)
        setTitleColor(textColorButton, for: .normal)
        setTitleColor(textColorButton?.withAlphaComponent(0.2), for: .highlighted)
        layer.borderColor = UIColor.appPrimaryColor.cgColor
        titleLabel?.font = fontButton
        backgroundColor = colorButton
        setImage(buttonImage, for: .normal)
        titleLabel?.textAlignment = .left
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
private extension ImageRchTitleRtoButtonTro {
    private func topImageConstraints() {
        titleLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView?.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: titleLabel?.topAnchor ?? centerYAnchor, constant: -8).isActive = true
    }
}
