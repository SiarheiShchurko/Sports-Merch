import UIKit

final class SportsTeamsContrlr: UIViewController {
    init(portsTeamsVm: SportTeamsProtocol) {
        self.sportsTeamsVm = sportsTeamsVm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Prprts
    private var isSearching: Bool = false
    private let sportsTeamsVm: SportTeamsProtocol
    
    // Labels
    private let headerLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "Sports teams",
                                                                     textColor: .white,
                                                                     font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize))
    
    private let teamsCountLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "",
                                                                         font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize))
    
    // Search bar
    private let sportsSearchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    // Buttons
    private let plusSportsButton: SimpleSecImageRaceButtonAts = SimpleSecImageRaceButtonAts(isSystem: true,
                                                                                            imgName: "plus",
                                                                                            color: .white)
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSportsTeamsContrlr()
        sportsTeamsContrlrConstraints()
    }
}

private extension SportsTeamsContrlr {
    func setSportsTeamsContrlr() {
        view.backgroundColor = .appMainBckgrd
        
    }
    
    func sportsTeamsContrlrConstraints() {
        view.addSubview(plusSportsButton)
        view.addSubview(headerLabel)
        view.addSubview(sportsSearchBar)
        view.addSubview(teamsCountLabel)
        NSLayoutConstraint.activate([
            plusSportsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusSportsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusSportsButton.widthAnchor.constraint(equalToConstant: 32),
            plusSportsButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerLabel.topAnchor.constraint(equalTo: plusSportsButton.bottomAnchor, constant: 4),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sportsSearchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            sportsSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sportsSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sportsSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
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
        
        let text = "\(completitionViewModele.completitions.count) competitions added"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttributes(firstCharacterAttributes, range: NSRange(location: 0, length: 1))
        attributedString.addAttributes(remainingCharactersAttributes, range: NSRange(location: 1, length: text.count - 1))
        
        trackCountLabel.attributedText = attributedString
    }
}
