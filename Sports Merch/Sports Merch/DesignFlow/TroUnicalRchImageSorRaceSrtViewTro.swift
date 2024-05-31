import UIKit
final class TroUnicalRchImageSorRaceSrtViewTro: UIImageView {
    init(imageName: String,
         comtentMode: UIView.ContentMode,
         backgroundColor: UIColor = .clear) {
        super.init(image: UIImage(named: imageName))
        setImageView(with: comtentMode, with: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TroUnicalRchImageSorRaceSrtViewTro {
    func setImageView(with myContentMode: UIView.ContentMode, with bckgrdClr: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bckgrdClr
        contentMode = myContentMode
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
