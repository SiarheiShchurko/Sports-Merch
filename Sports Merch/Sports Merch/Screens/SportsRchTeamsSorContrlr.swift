import UIKit

final class SportsRchTeamsSorContrlr: UIViewController {
    init(sportsTeamsVm: SportsRchTeamsSorProtocol,
         pickerContr: SorPickerRemControllerSor,
         fileManager: FileManagerServiceProtocol) {
        self.sportsTeamsVm = sportsTeamsVm
        self.picker = pickerContr
        self.fileManagerService = fileManager
        super.init(nibName: nil,
                   bundle: nil)
        updateTeams()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Prprts
    private var isSearching: Bool = false
    private let picker: SorPickerRemControllerSor
    private let sportsTeamsVm: SportsRchTeamsSorProtocol
    private let fileManagerService: FileManagerServiceProtocol
    
    // Labels
    private let headerLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "Sports teams",
                                                                     textColor: .white,
                                                                     font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.mainFontSize))
    
    private let teamsCountLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "",
                                                                         font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                                         textAlignment: .center)
    
    private let emptyLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "\nThere are no records",
                                                                    textColor: .black,
                                                                    font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                                    textAlignment: .center)
    
    private let bottomEmptyLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "")
    
    // Image
    private let emptyTeamsImage = TroUnicalRchImageSorRaceSrtViewTro(imageName: "emptyTeamImg",
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
            .font: UIFont.systemFont(ofSize: CGFloat.RchsFontSorSizeTro.secondFontSize)]
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
        
        return searchBar
    }()
    
    // Buttons
    private let plusSportsButton: SimpleTroImageRchButtonTro = SimpleTroImageRchButtonTro(isSystem: true,
                                                                                            imgName: "plus",
                                                                                            color: .white)
    // Collection View
    private let teamsCollectionView = TroTopCollectionRchsViewOrt(cellClass: TeamsRtoCellRch.self,
                                                                  id: "\(TeamsRtoCellRch.self)",
                                                                  backgroudClr: .appMainBckgrd,
                                                                  scrollDirection: .vertical)
    // Stacks
    private lazy var emptyStack = RchUniqueStackRtoViewSor(views: [emptyLabel, emptyTeamsImage, bottomEmptyLabel],
                                                          axis: .vertical,
                                                          alignment: .fill,
                                                          distribution: .fillProportionally,
                                                          spacing: 16,
                                                          backgroundColor: .white,
                                                          cornerRadius: 16)
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSportsTeamsContrlr()
        teamsTargets()
        sportsTeamsContrlrConstraints()
    }
}

private extension SportsRchTeamsSorContrlr {
    func teamsTargets() {
        plusSportsButton.addTarget(self, action: #selector(plusDidTapped), for: .touchUpInside)
    }
}

private extension SportsRchTeamsSorContrlr {
    @objc func plusDidTapped() {
        let newTeamController = NewRchTeamSorScreenTop(newTeamVm: NewTopTeamSorVmRch(fileManager: fileManagerService),
                                              currentTeam: nil,
                                              picker: picker)
        newTeamController.sportsTeamDelegate = self
        navigationController?.pushViewController(newTeamController, animated: true)
    }
}

private extension SportsRchTeamsSorContrlr {
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

private extension SportsRchTeamsSorContrlr {
    func setSportsTeamsContrlr() {
        view.backgroundColor = .appMainBckgrd
        view.hideRchKeyboardTop()
        
        teamsCollectionView.dataSource = self
        teamsCollectionView.delegate = self
        
        sportsSearchBar.delegate = self
        
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

private extension SportsRchTeamsSorContrlr {
    func setSportScreenData() {
        let firstCharacterAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appPrimaryColor,
            .font: UIFont.boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize)
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

extension SportsRchTeamsSorContrlr: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isSearching ? sportsTeamsVm.searchingTeams.count : sportsTeamsVm.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TeamsRtoCellRch.self)", for: indexPath) as? TeamsRtoCellRch else {
            return UICollectionViewCell()
        }
        let team: SorTeamRch
        isSearching ? (team = sportsTeamsVm.searchingTeams[indexPath.row]) : (team = sportsTeamsVm.teams[indexPath.row])
        cell.set(team)
        return cell
    }
}

extension SportsRchTeamsSorContrlr: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentTeam: SorTeamRch
        isSearching ? (currentTeam = sportsTeamsVm.searchingTeams[indexPath.row]) : (currentTeam = sportsTeamsVm.teams[indexPath.row])
        
        let newTeamController = NewRchTeamSorScreenTop(newTeamVm: NewTopTeamSorVmRch(fileManager: fileManagerService),
                                              currentTeam: currentTeam,
                                              picker: picker)
        newTeamController.sportsTeamDelegate = self
        navigationController?.pushViewController(newTeamController, animated: true)
    }
}

extension SportsRchTeamsSorContrlr: UICollectionViewDelegateFlowLayout {
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

// MARK: - SearchBar ext
extension SportsRchTeamsSorContrlr: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ///
        sportsTeamsVm.searchingTeams.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        if searchBar.text == "" {
            isSearching = false
            DispatchQueue.main.async { [ weak self ] in
                self?.teamsCollectionView.reloadData()
            }
            
        } else {
            isSearching = true
            guard let signalName = searchBar.text else {
                return
            }
            sportsTeamsVm.searchingText = signalName
        }
        isSearching && sportsTeamsVm.searchingTeams.count == 0 ? (emptyStack.isHidden = false) : (emptyStack.isHidden = true)
    }
}

extension SportsRchTeamsSorContrlr: TransitObjectsDelegateProtocol {
    func update<T>(oldValue: T, for newValue: T) where T : Decodable, T : Encodable {
        isSearching = false
        sportsSearchBar.text = ""
        
        if let newCurrentTeam = newValue as? SorTeamRch,
           let oldCurrentTeam = oldValue as? SorTeamRch {
            sportsTeamsVm.update(oldTeam: oldCurrentTeam, for: newCurrentTeam)
        }
    }
    
    func add<T>(new: T) where T : Decodable, T : Encodable {
        isSearching = false
        sportsSearchBar.text = ""
        if let newTeam = new as? SorTeamRch {
            sportsTeamsVm.add(new: newTeam)
        }
    }
    
    func delete<T>(_ attribute: T) where T : Decodable, T : Encodable {
        isSearching = false
        sportsSearchBar.text = ""
        if let deletingTeam = attribute as? SorTeamRch {
            sportsTeamsVm.delete(deletingTeam)
        }
    }
}
