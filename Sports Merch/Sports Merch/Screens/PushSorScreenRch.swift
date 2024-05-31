import UIKit
//import OneSignalFramework

final class PushSorScreenRch: UIViewController {
    
    private let bottomOffsetForIpad: CGFloat = {
        SorDefltsRchsServiceChe.remUsrRchsDvcChe != .phone ? (CGFloat.RchsFontSorSizeTro.mainFontSize * 15) : (CGFloat.RchsFontSorSizeTro.mainFontSize * 3)
    }()
    
    private lazy var  mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don’t miss anything"
        label.textColor = .black
        label.textAlignment  = .center
        label.font = .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.mainFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .secondTextColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: CGFloat.RchsFontSorSizeTro.secondFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "PushNotification")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var continueButton = RchsPrimaryTopButtonTro(title: "Enable notifications",
                                                         mainTitleColor: .white,
                                                         font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize))
    private let skipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "CloseButton"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMainBckgrd
        addTargets()
        addSubviews()
        constraints()
    }
}
private extension PushSorScreenRch {
    func addTargets() {
        skipButton.addTarget(self, action: #selector(skipDidTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
    }
}
private extension PushSorScreenRch {
    @objc func skipDidTapped() {
        openArtFullRams(vc: WController())
    }
    @objc private func nextBtnClicked() {
        callPush()
    }
}
private extension PushSorScreenRch {
    func addSubviews() {
        view.addSubview(mainImage)
        view.addSubview(mainLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
    }
}
private extension PushSorScreenRch {
    
    private func constraints() {
        NSLayoutConstraint.activate([
            
            mainLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            secondaryLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -4),
            secondaryLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
            
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomOffsetForIpad),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            skipButton.widthAnchor.constraint(equalToConstant: 32),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            skipButton.heightAnchor.constraint(equalToConstant: 32),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
            continueButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
        ])
    }
}

extension PushSorScreenRch {
    func callPush() {
//        OneSignal.initialize("", withLaunchOptions: RaceDefltsAtsServiceCes.staOptionsCesLaunchesEca)
//        OneSignal.Notifications.requestPermission({ [ weak self ] accepted in
//            if accepted {
//                OneSignal.login(RaceDefltsAtsServiceCes.staAppHudRaceUserIdEca)
//                self?.skipDidTapped()
//            } else {
//                self?.skipDidTapped()
//            }
//        }, fallbackToSettings: true)
    }
}


