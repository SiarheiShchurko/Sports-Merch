import UIKit
final class ClasPrimarySecButtonRace: UIButton {
    private let mainTitleColor: UIColor
    init(title: String,
         mainTitleColor: UIColor = .white,
         font: UIFont = .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
         isEnabled: Bool = true) {
        self.mainTitleColor = mainTitleColor
        super.init(frame: .zero)
        settingButton(with: title, with: mainTitleColor, with: font, with: isEnabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? setTitleColor(.black.withAlphaComponent(0.3), for: .normal) : setTitleColor(mainTitleColor, for: .normal)
        }
    }
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = .appPrimaryColor
                setTitleColor(mainTitleColor, for: .normal)
            } else {
                backgroundColor = .disabledAppPrimaryColor
                setTitleColor(.secondTextColor, for: .disabled)
            }
        }
    }
}

private extension ClasPrimarySecButtonRace {
    private func settingButton(  with title: String = "",
                                 with mainTitleColor: UIColor,
                                 with font: UIFont,
                                 with isEnabled: Bool = true
    ) {
       
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appPrimaryColor
        setTitle(title, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = 16
        clipsToBounds = true
        
        self.isEnabled = isEnabled
    }
}
