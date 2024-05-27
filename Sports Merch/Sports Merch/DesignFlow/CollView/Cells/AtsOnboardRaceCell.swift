import UIKit
final class AtsOnboardRaceCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
}
extension AtsOnboardRaceCell {
    func setCell(slide: SecOnboardArtsTypeRace, isView: Bool, index: Int) {
        mainImage.image = UIImage(named: slide.imageName)
    }
}

private extension AtsOnboardRaceCell {
    func addSubviews() {
        addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 48),
            mainImage.topAnchor.constraint(equalTo: topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
