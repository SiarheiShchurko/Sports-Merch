import UIKit
final class PrefRchsCellSor: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainFontSize: CGFloat = {
        CGFloat.RaceFontArtSizeSec.midleFontSize
    }()
    
    private lazy var sizeForIcon = mainFontSize * 2
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: mainFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
}

// Private ext
private extension PrefRchsCellSor {
    func addSubviews() {
        addSubview(mainLabel)
        addSubview(iconImage)
    }
    func setLayout() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: centerYAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: sizeForIcon),
            iconImage.widthAnchor.constraint(equalToConstant: sizeForIcon),
            iconImage.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: -8)
        ])
    }
}

// Ext
extension PrefRchsCellSor {
    func set(_ quilElement: EthereTypeUell) {
        mainLabel.text = quilElement.itemName
        iconImage.image = UIImage(systemName: quilElement.imageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
}
