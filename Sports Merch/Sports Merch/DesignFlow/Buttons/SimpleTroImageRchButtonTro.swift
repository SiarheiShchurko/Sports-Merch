import UIKit
final class SimpleTroImageRchButtonTro: UIButton {
    convenience init(isSystem: Bool,
                     imgName: String,
                     color: UIColor = .clear,
                     backgroundClr: UIColor = .clear,
                     contentMode: UIView.ContentMode = .scaleAspectFit,
                     isEnabled: Bool = true) {
        self.init(type: .system)
        setButton(isSystem: isSystem, img: imgName, imgColor: color, backgroundClr: backgroundClr, contentMode: contentMode, isEnabled: isEnabled)
    }
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.opacity = 1
            } else {
                layer.opacity = 0.5
            }
        }
    }
}

// MARK: - private extension
private extension SimpleTroImageRchButtonTro {
    func setButton(isSystem: Bool, img: String, imgColor: UIColor, backgroundClr: UIColor, contentMode: UIView.ContentMode, isEnabled: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundClr
        self.isEnabled = isEnabled
        self.contentMode = contentMode
        
        if isSystem {
            setImage(UIImage(systemName: img)?.withTintColor(imgColor, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            if imgColor != .clear {
                setImage(UIImage(named: img)?.withTintColor(imgColor, renderingMode: .alwaysOriginal), for: .normal)
            } else {
                setImage(UIImage(named: img)?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
}
