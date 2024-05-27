
import UIKit
import StoreKit
final class OnboardingRaceScreenAts: UIViewController {
    init(isView: Bool,
         onboardingModele: OnboardingAtsProtocol) {
        self.isView = isView
        self.onboardingModele = onboardingModele
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Properties
    private let isView: Bool
    private let onboardingModele: OnboardingAtsProtocol
    
    private let customContainerViewTopConstraintsPoint: CGFloat = {
         CGFloat.RaceFontArtSizeSec.mainFontSize * 5
    }()
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            setLabels()
        }
    }
    
    // Label
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize)
        label.textColor = .mainTextColor
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    // Views
    private let customContainerView: UIView = {
      let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 16
        return view
    }()
    
    // Buttons
    private lazy var nextButton = ClasPrimarySecButtonRace(title: "Next",
                                                     font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize))
    
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.cornerRadius = 8
        control.isUserInteractionEnabled = false
        control.numberOfPages = onboardingModele.array.count
        control.currentPageIndicatorTintColor = .appPrimaryColor
        control.pageIndicatorTintColor = .disabledAppPrimaryColor
        if #available(iOS 14.0, *) {
            control.preferredIndicatorImage = UIImage(named: "pageControlIndicator")
        }
        return control
    }()
    
    // Collection view
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.backgroundColor = .clear
        collView.register(AtsOnboardRaceCell.self, forCellWithReuseIdentifier: "\(AtsOnboardRaceCell.self)")
        collView.isPagingEnabled = true
        collView.showsHorizontalScrollIndicator = false
        collView.isUserInteractionEnabled = false
        collView.translatesAutoresizingMaskIntoConstraints = false
        return collView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLabels()
        addTarget()
        addSubviews()
        constraints()
    }
}

private extension OnboardingRaceScreenAts {
    func setView() {
        view.backgroundColor = .appMainBckgrd
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(customContainerView)
        view.addSubview(mainLabel)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                customContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                customContainerView.topAnchor.constraint(equalTo: nextButton.topAnchor, constant: -customContainerViewTopConstraintsPoint),
                customContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                customContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                mainLabel.topAnchor.constraint(equalTo: customContainerView.topAnchor, constant: 16),
                mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                pageControl.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
                pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
    }
    
    func setLabels() {
        mainLabel.text = " \(onboardingModele.array[currentPage].mainText) "
    }
}

private extension OnboardingRaceScreenAts {
    func addTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
    }
}

private extension OnboardingRaceScreenAts {
    @objc func nextButtonDidTapped() {
        switch currentPage {
        case onboardingModele.array.count - 1:
            screenRouter()
        case onboardingModele.array.count - 2:
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        default:
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        }
    }
}

extension OnboardingRaceScreenAts: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingModele.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AtsOnboardRaceCell.self)", for: indexPath) as? AtsOnboardRaceCell else {
            return UICollectionViewCell()
        }
        cell.setCell(slide: onboardingModele.array[indexPath.row],
                     isView: isView,
                     index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

private extension OnboardingRaceScreenAts {
    func rateFunc() {
        if #available(iOS 14.0, *),
           let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
}

private extension OnboardingRaceScreenAts {
    func screenRouter() {
        RaceDefltsAtsServiceCes.isRaceOnboardingStaDidShowedSec = true
        let vc: UIViewController
        if isView {
            vc = PushAtrScreenRace()
        } else {
            vc = UINavigationController(rootViewController: TabBarRaceModuleSec())
        }
        openArtFullRams(vc: vc)
    }
}
