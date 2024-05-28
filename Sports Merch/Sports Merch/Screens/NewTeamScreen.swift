import UIKit

final class NewTeamScreen: UIViewController {
    init(newTeamVm: NewTeamProtocol,
         currentTeam: Team?,
         picker: RacePickerController) {
        self.newTeamVm = newTeamVm
        self.picker = picker
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Property
    weak var sportsTeamDelegate: TransitObjectsDelegateProtocol?
    
    private var currentTeam: Team?
    private let newTeamVm: NewTeamProtocol
    private let picker: RacePickerController
    
    private lazy var textFieldsArray: [SecUnicalRaceTFAts] = [nameTextField, contactNumberTextField]
    
    // Labels
    private let titleLabel = SecSimpleLabelRace(text: "",
                                                font: .boldSystemFont(ofSize: 17))
    // Views
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    // Image
    private let teamAvatar = SecUnicalImageRaceViewAts(imageName: "",
                                                       comtentMode: .scaleAspectFill)
    // Buttons
    private let addAttributeButton = ImageTitleButton(titleButton: "+ Add more",
                                                      colorButton: .white,
                                                      fontButton: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize))
    
    private let saveButton = ClasPrimarySecButtonRace(title: "",
                                                      font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                      isEnabled: false)
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 16
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.appPrimaryColor, for: .normal)
        button.layer.borderColor = UIColor.appPrimaryColor.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // TextFields
    private let nameTextField = SecUnicalRaceTFAts(placeholder: "Name")
    
    private let contactNumberTextField = SecUnicalRaceTFAts(placeholder: "+1392847562",
                                                            keyboardType: .namePhonePad,
                                                            isCanPerformAction: false)
    // Table view
    private let teamTableView = TraTableGniViewArt(color: .white,
                                                   registerClass: TeamAttributesTableViewCell.self,
                                                   cell: "\(TeamAttributesTableViewCell.self)",
                                                   rowHeigh: UITableView.automaticDimension,
                                                   separatorStyle: .singleLine)
    // Stack
    private lazy var textFieldStack = SecUniqueStackViewGniff(views: [nameTextField,
                                                                      contactNumberTextField],
                                                              axis: .vertical,
                                                              alignment: .fill,
                                                              spacing: 16)
    
    private lazy var buttonsStack = SecUniqueStackViewGniff(views: [deleteButton,
                                                                      saveButton],
                                                              axis: .horizontal,
                                                              alignment: .fill,
                                                            distribution: .fillEqually,
                                                              spacing: 16)
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        newTeamTargets()
        constraints()
    }
}

// SetView
private extension NewTeamScreen {
    func setView() {
        view.backgroundColor = .white
        view.hideKeyboard()
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = .appPrimaryColor
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        textFieldsArray.forEach({
            $0.layer.borderColor = UIColor.appPrimaryColor.cgColor
            $0.layer.borderWidth = 1.0
        })
        
        teamTableView.dataSource = self
        
        currentTeam != nil ? setEditingItemUI() : setNewItemUI()
    }
    
    func constraints() {
        view.addSubview(teamAvatar)
        view.addSubview(textFieldStack)
        view.addSubview(addAttributeButton)
        view.addSubview(teamTableView)
        view.addSubview(buttonsStack)
        NSLayoutConstraint.activate([
            teamAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            teamAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            teamAvatar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            teamAvatar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            contactNumberTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            
            textFieldStack.topAnchor.constraint(equalTo: teamAvatar.bottomAnchor, constant: 16),
            textFieldStack.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            textFieldStack.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            
            addAttributeButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 16),
            addAttributeButton.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            addAttributeButton.widthAnchor.constraint(equalToConstant: 100),
            addAttributeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            teamTableView.topAnchor.constraint(equalTo: addAttributeButton.bottomAnchor, constant: 8),
            teamTableView.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            teamTableView.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            teamTableView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -8),
            
            buttonsStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            buttonsStack.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setNewItemUI() {
        saveButton.setTitle("Add", for: .normal)
        titleLabel.text = "Create"
        teamAvatar.image = UIImage(named: "emptyStrAvatarEchImg")
        deleteButton.setTitle("Cancel", for: .normal)
    }
    
    func setEditingItemUI() {
        saveButton.setTitle("Save", for: .normal)
        titleLabel.text = "Edit"
        
        if let currentTeam {
            nameTextField.text = currentTeam.teamName
            contactNumberTextField.text = currentTeam.phoneNumber
            newTeamVm.attributes = currentTeam.brandAttributes
        }
    }
}

private extension NewTeamScreen {
    func newTeamTargets() {
        deleteButton.addTarget(self, action: #selector(deleteDidTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        
        addAttributeButton.addTarget(self, action: #selector(addAttributedDidTapped), for: .touchUpInside)
        textFieldsArray.forEach({ $0.addTarget(self, action: #selector(teamsTextFieldScreenDidChanged), for: .editingChanged) })
    }
}

private extension NewTeamScreen {
    @objc func teamsTextFieldScreenDidChanged() {
        guard let name = nameTextField.text?.replacingOccurrences(of: " ", with: ""),
              let numberPhone = contactNumberTextField.text?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        saveButton.isEnabled = !name.isEmpty && !numberPhone.isEmpty
    }
    
    @objc func addAttributedDidTapped() {
        
    }
    
    @objc func deleteDidTapped() {
        
    }
    
    @objc func saveDidTapped() {
        
    }
}

extension NewTeamScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newTeamVm.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TeamAttributesTableViewCell.self)", for: indexPath) as? TeamAttributesTableViewCell else {
            return UITableViewCell()
        }
        let team = newTeamVm.attributes[indexPath.row]
        cell.set(team)
        return cell
    }
}

// Delegate
extension NewTeamScreen: TransitObjectsDelegateProtocol {
    func add<T>(new: T) where T : Decodable, T : Encodable {
        //
    }
    
    func delete<T>(_ attribute: T) where T : Decodable, T : Encodable {
        //
    }
}

private extension NewTeamScreen {
    
}
