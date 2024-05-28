import UIKit

final class SportsTeamsContrlr: UIViewController {
    init(sportsTeamsVm: SportsTeamsProtocol,
         pickerContr: RacePickerController) {
        self.sportsTeamsVm = sportsTeamsVm
        self.picker = pickerContr
        super.init(nibName: nil,
                   bundle: nil)
        updateTeams()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Prprts
    private var isSearching: Bool = false
    private let picker: RacePickerController
    private let sportsTeamsVm: SportsTeamsProtocol
    
    // Labels
    private let headerLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "Sports teams",
                                                                     textColor: .white,
                                                                     font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize))
    
    private let teamsCountLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "",
                                                                         font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                                         textAlignment: .center)
    
    private let emptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "There are no records",
                                                                    textColor: .black,
                                                                    font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                                    textAlignment: .center)
    
    private let bottomEmptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "")
    
    // Image
    private let emptyTeamsImage = SecUnicalImageRaceViewAts(imageName: "emptyTeamImg",
                                                            comtentMode: .scaleAspectFit)
    
    // Search bar
    private let sportsSearchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.textColor = .white
        
        searchBar.searchTextField.leftView?.tintColor = .white
        
        // Set attr
        let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize)]
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
        
        return searchBar
    }()
    
    // Buttons
    private let plusSportsButton: SimpleSecImageRaceButtonAts = SimpleSecImageRaceButtonAts(isSystem: true,
                                                                                            imgName: "plus",
                                                                                            color: .white)
    // Collection View
    private let teamsCollectionView = SecTimCollectionRaceViewAts(cellClass: TeamsCellRch.self,
                                                                  id: "\(TeamsCellRch.self)",
                                                                  backgroudClr: .appMainBckgrd,
                                                                  scrollDirection: .vertical)
    // Stacks
    private lazy var emptyStack = SecUniqueStackViewGniff(views: [emptyLabel, emptyTeamsImage, bottomEmptyLabel],
                                                         axis: .vertical,
                                                         alignment: .fill,
                                                         distribution: .fillProportionally,
                                                         spacing: 16,
                                                         backgroundColor: .white)
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSportsTeamsContrlr()
        teamsTargets()
        sportsTeamsContrlrConstraints()
    }
}

private extension SportsTeamsContrlr {
    func teamsTargets() {
        plusSportsButton.addTarget(self, action: #selector(plusDidTapped), for: .touchUpInside)
    }
}

private extension SportsTeamsContrlr {
    @objc func plusDidTapped() {
        let newTeamController = NewTeamScreen(newTeamVm: NewTeamVm(fileManager: FileManagerService()),
                                              currentTeam: nil,
                                              picker: picker)
        newTeamController.sportsTeamDelegate = self
        navigationController?.pushViewController(newTeamController, animated: true)
    }
}

private extension SportsTeamsContrlr {
    func updateTeams() {
        sportsTeamsVm.updateTeams = { [ weak self ] in
            guard let self else {
                return
            }
            self.setSportScreenData()
            self.teamsCollectionView.reloadData()
            self.emptyStack.isHidden = !self.sportsTeamsVm.teams.isEmpty
        }
    }
}

private extension SportsTeamsContrlr {
    func setSportsTeamsContrlr() {
        view.backgroundColor = .appMainBckgrd
        
        teamsCountLabel.layer.cornerRadius = 16
        teamsCountLabel.layer.backgroundColor = UIColor.white.cgColor
        
        setSportScreenData()
    }
    
    func sportsTeamsContrlrConstraints() {
        
        view.addSubview(headerLabel)
        view.addSubview(plusSportsButton)
        view.addSubview(sportsSearchBar)
        view.addSubview(teamsCountLabel)
        view.addSubview(teamsCollectionView)
        view.addSubview(emptyStack)
        
        NSLayoutConstraint.activate([
            plusSportsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusSportsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusSportsButton.widthAnchor.constraint(equalToConstant: 32),
            plusSportsButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerLabel.bottomAnchor.constraint(equalTo: plusSportsButton.bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sportsSearchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            sportsSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sportsSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sportsSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            teamsCountLabel.topAnchor.constraint(equalTo: sportsSearchBar.bottomAnchor, constant: 16),
            teamsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            teamsCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            teamsCollectionView.topAnchor.constraint(equalTo: teamsCountLabel.bottomAnchor, constant: 16),
            teamsCollectionView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            teamsCollectionView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            teamsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyStack.topAnchor.constraint(equalTo: teamsCollectionView.topAnchor),
            emptyStack.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            emptyStack.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor)
        ])
    }
}

private extension SportsTeamsContrlr {
    func setSportScreenData() {
        let firstCharacterAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appPrimaryColor,
            .font: UIFont.boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize)
        ]
        
        let remainingCharactersAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.mainTextColor
        ]
        
        let text = "\n\(sportsTeamsVm.teams.count) teams have been added\n"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttributes(firstCharacterAttributes, range: NSRange(location: 0, length: 1))
        attributedString.addAttributes(remainingCharactersAttributes, range: NSRange(location: 1, length: text.count - 1))
        
        teamsCountLabel.attributedText = attributedString
    }
}

extension SportsTeamsContrlr: TransitObjectsDelegateProtocol {
    func add<T>(new: T) where T : Decodable, T : Encodable {
        if let newTeam = new as? Team {
            print("")
        }
    }
    
    func delete<T>(_ attribute: T) where T : Decodable, T : Encodable {
        if let deletingTeam = attribute as? Team {
            print("")
        }
    }
}
