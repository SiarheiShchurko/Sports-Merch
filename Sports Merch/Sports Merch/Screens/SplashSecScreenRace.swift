
import UIKit
//import Apphud

class SplashSecScreenRace: UIViewController {
    init(isGtv: Bool) {
        self.isGtv = isGtv
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let isGtv: Bool
    
    private let percentLoadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .secondTextColor
        label.textAlignment = .center
        return label
    }()
    
    // Image
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .secondTextColor
        return activityIndicator
    }()
    
    // LC
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        addSubviews()
        loadingAnimation()
        startCounting()
        checkStrana()
        setAdditionalParametrs()
    }
}

// MARK: - Load indicator
private extension SplashSecScreenRace {
    func startCounting() {
        DispatchQueue.global().async {
            for i in 0...100 {
                DispatchQueue.main.async {
                    self.percentLoadingLabel.text = "\(i)%"
                }
                Thread.sleep(forTimeInterval: 0.025)
            }
        }
    }
    func loadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            UIView.animate(withDuration: 3) { [ weak self ] in
                self?.activityIndicator.startAnimating()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [ weak self ] in
            guard let self else {
                return
            }
            self.screenRouter()
        }
    }
}

// MARK: - Add Subviews
private extension SplashSecScreenRace {
    func addSubviews() {
        view.addSubview(logoImage)
        view.addSubview(activityIndicator)
        view.addSubview(percentLoadingLabel)
        NSLayoutConstraint.activate([
            logoImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            
            percentLoadingLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4),
            percentLoadingLabel.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor),
            
            activityIndicator.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4),
            activityIndicator.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: view.frame.height * 0.2)
        ])
    }
}

// Router
private extension SplashSecScreenRace {
    func screenRouter() {
        let vc: UIViewController
        
        RaceDefltsAtsServiceCes.isRaceOnboardingStaDidShowedSec ?
        (vc = UINavigationController(rootViewController: TabBarRaceModuleSec())) :
        (vc = OnboardingRaceScreenAts(isView: false,
                                      onboardingModele: OnboardingRaceViewAtsModel(isView: false)))
        
        openArtFullRams(vc: vc)
    }
}
private extension SplashSecScreenRace {
    func setViewController() {
        view.backgroundColor = .appMainBckgrd
    }
    
    func checkStrana() {
        let currentLocale = Locale.current
        if let stranaKod = currentLocale.regionCode {
            if let stranaName = currentLocale.localizedString(forRegionCode: stranaKod) {
                RaceDefltsAtsServiceCes.staObitationEca = stranaName
            }
        }
    }
    
    func setAdditionalParametrs() {
        if RaceDefltsAtsServiceCes.staAppHudRaceUserIdEca.isEmpty {
            
        }
    }
}
