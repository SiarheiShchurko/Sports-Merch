import UIKit
final class SecSimpleLabelRace: UILabel {
    init(text: String,
         textColor: UIColor = .mainTextColor,
         font: UIFont = .systemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize),
         numberOfLines: Int = 0,
         textAlignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        setLabel(with: text, with: textColor, with: font, numberOfLines: numberOfLines, textAlignment: textAlignment)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SecSimpleLabelRace {
    func setLabel(with text: String, with textColor: UIColor, with font: UIFont, numberOfLines: Int, textAlignment: NSTextAlignment) {
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
