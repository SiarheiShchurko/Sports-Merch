import UIKit

final class TheShopsContrlr: UIViewController {
    init(shopsErchVm: ShopsErchProtocol,
         pickerContr: RacePickerController,
         fileManager: FileManagerServiceProtocol) {
        self.shopsErchVm = shopsErchVm
        self.picker = pickerContr
        self.fileManagerService = fileManager
        super.init(nibName: nil,
                   bundle: nil)
        updateErchShops()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Prprts
    private var isSearching: Bool = false
    private let picker: RacePickerController
    private let shopsErchVm: ShopsErchProtocol
    private let fileManagerService: FileManagerServiceProtocol
    
    // Labels
    private let headerLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "The shops",
                                                                     textColor: .white,
                                                                     font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize))
    
    private let emptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "\nAdd your first store",
                                                                    textColor: .black,
                                                                    font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                                    textAlignment: .center)
    
    private let bottomEmptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "")
    
    // Image
    private let emptyTeamsImage = SecUnicalImageRaceViewAts(imageName: "emptyTeamImg",
                                                            comtentMode: .scaleAspectFit)
    // Buttons
    private let plusShopsErchButton: SimpleSecImageRaceButtonAts = SimpleSecImageRaceButtonAts(isSystem: true,
                                                                                            imgName: "plus",
                                                                                            color: .white)
    private let addStackEachButton = ClasPrimarySecButtonRace(title: "Add")
    
    // CollectionView
    private let shopsCollectionView = SecTimCollectionRaceViewAts(cellClass: ShopsCellRch.self,
                                                                  id: "\(ShopsCellRch.self)",
                                                                  backgroudClr: .appMainBckgrd,
                                                                  scrollDirection: .horizontal)
    
    // Stacks
    private lazy var emptyStack = SecUniqueStackViewGniff(views: [emptyLabel, emptyTeamsImage, addStackEachButton, bottomEmptyLabel],
                                                          axis: .vertical,
                                                          alignment: .fill,
                                                          distribution: .fillProportionally,
                                                          spacing: 16,
                                                          backgroundColor: .white,
                                                          cornerRadius: 16)
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setShopsErchController()
        setShopsErchConstraints()
    }
}


private extension TheShopsContrlr {
    func updateErchShops() {
        //
    }
}

private extension TheShopsContrlr {
    func setShopsErchController() {
        view.backgroundColor = .appMainBckgrd
        
        shopsCollectionView.dataSource = self
        shopsCollectionView.delegate = self
    }
    
    func setShopsErchConstraints() {
        view.addSubview(headerLabel)
        view.addSubview(plusShopsErchButton)
        
        view.addSubview(emptyStack)
        NSLayoutConstraint.activate([
            plusShopsErchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusShopsErchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusShopsErchButton.widthAnchor.constraint(equalToConstant: 32),
            plusShopsErchButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerLabel.bottomAnchor.constraint(equalTo: plusShopsErchButton.bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emptyStack.topAnchor.constraint(equalTo: shopsCollectionView.topAnchor),
            emptyStack.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            emptyStack.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor)
        
        ])
    }
}

extension TheShopsContrlr: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopsErchVm.shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TeamsCellRch.self)", for: indexPath) as? ShopsCellRch else {
            return UICollectionViewCell()
        }
        let team: TeamEachShop
        isSearching ? (team = sportsTeamsVm.searchingTeams[indexPath.row]) : (team = sportsTeamsVm.teams[indexPath.row])
        cell.set(team)
        return cell
    }
}

extension TheShopsContrlr: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentTeam: TeamEachShop
        isSearching ? (currentTeam = sportsTeamsVm.searchingTeams[indexPath.row]) : (currentTeam = sportsTeamsVm.teams[indexPath.row])
        
        let newTeamController = NewTeamScreen(newTeamVm: NewTeamVm(fileManager: fileManagerService),
                                              currentTeam: currentTeam,
                                              picker: picker)
        newTeamController.sportsTeamDelegate = self
        navigationController?.pushViewController(newTeamController, animated: true)
    }
}

extension SportsTeamsContrlr: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 2.1
        let height: CGFloat
        view.frame.height > 700 ? (height = collectionView.bounds.height / 2.15) : (height = collectionView.bounds.height / 1.4)
        return CGSize(width: width, height: height)
    }
}
