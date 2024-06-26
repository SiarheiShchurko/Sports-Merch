import UIKit

final class NewRchTeamSorScreenTop: UIViewController {
    init(newTeamVm: NewTeamProtocol,
         currentTeam: SorTeamRch?,
         picker: SorPickerRemControllerSor) {
        self.newTeamVm = newTeamVm
        self.currentTeam = currentTeam
        self.picker = picker
        super.init(nibName: nil,
                   bundle: nil)
        updateVmParams()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Property
    weak var sportsTeamDelegate: TransitObjectsDelegateProtocol?
    
    private var coverTeamsData: Data?
    private let currentTeam: SorTeamRch?
    
    private let newTeamVm: NewTeamProtocol
    private let picker: SorPickerRemControllerSor
    
    private lazy var textFieldsArray: [RchUnicalTroTfSor] = [nameTextField, contactNumberTextField]
    
    // Labels
    private let titleLabel = TroSimpleTroLabelRch(text: "",
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
    private let teamAvatar = TroUnicalRchImageSorRaceSrtViewTro(imageName: "",
                                                       comtentMode: .scaleAspectFill)
    // Buttons
    private let addAttributeButton = ImageRchTitleRtoButtonTro(titleButton: "+ Add more",
                                                      colorButton: .white,
                                                      fontButton: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize))
    
    private let saveButton = RchsPrimaryTopButtonTro(title: "",
                                                      font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                      isEnabled: false)
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 16
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.appPrimaryColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize)
        button.layer.borderColor = UIColor.appPrimaryColor.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // TextFields
    private let nameTextField = RchUnicalTroTfSor(placeholder: "Name")
    
    private let contactNumberTextField = RchUnicalTroTfSor(placeholder: "+1392847562",
                                                            keyboardType: .decimalPad,
                                                            isCanPerformAction: false)
    // Table view
    private let teamTableView = TroTableOrtViewRch(color: .white,
                                                   registerClass: TeamAttributesTroTableViewCellRch.self,
                                                   cell: "\(TeamAttributesTroTableViewCellRch.self)",
                                                   rowHeigh: UITableView.automaticDimension,
                                                   separatorStyle: .none)
    // Stack
    private lazy var textFieldStack = RchUniqueStackRtoViewSor(views: [nameTextField,
                                                                      contactNumberTextField],
                                                              axis: .vertical,
                                                              alignment: .fill,
                                                              spacing: 16)
    
    private lazy var buttonsStack = RchUniqueStackRtoViewSor(views: [deleteButton,
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
private extension NewRchTeamSorScreenTop {
    func setView() {
        view.backgroundColor = .white
        view.hideRchKeyboardTop()
        
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
        view.addSubview(activityIndicator)
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
            addAttributeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            teamTableView.topAnchor.constraint(equalTo: addAttributeButton.bottomAnchor, constant: 8),
            teamTableView.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            teamTableView.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            teamTableView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -8),
            
            buttonsStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            buttonsStack.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            activityIndicator.centerXAnchor.constraint(equalTo: teamAvatar.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: teamAvatar.centerYAnchor)
        ])
    }
    
    func setNewItemUI() {
        saveButton.setTitle("Add", for: .normal)
        titleLabel.text = "Create"
        teamAvatar.image = UIImage(named: "emptyStrAvatarEchImg")
        deleteButton.isHidden = true
    }
    
    func setEditingItemUI() {
        saveButton.setTitle("Save", for: .normal)
        titleLabel.text = "Edit"
        
        if let currentTeam {
            
            nameTextField.text = currentTeam.teamName
            contactNumberTextField.text = currentTeam.phoneNumber
            newTeamVm.attributes = currentTeam.brandAttributes
            
            if let imageDta = newTeamVm.loadImage(with: currentTeam.imageName) {
                teamAvatar.image = UIImage(data: imageDta)
            } else {
                teamAvatar.image = UIImage(named: "emptyStrAvatarEchImg")
            }
        }
    }
}

private extension NewRchTeamSorScreenTop {
    func updateVmParams() {
        newTeamVm.updateAttributes = { [ weak self ] in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                self.teamTableView.reloadData()
                self.teamsTextFieldScreenDidChanged()
            }
        }
        }
    }


private extension NewRchTeamSorScreenTop {
    func newTeamTargets() {
        deleteButton.addTarget(self, action: #selector(deleteDidTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        addAttributeButton.addTarget(self, action: #selector(addAttributedDidTapped), for: .touchUpInside)
        textFieldsArray.forEach({ $0.addTarget(self, action: #selector(teamsTextFieldScreenDidChanged), for: .editingChanged) })
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageDidTapped))
        teamAvatar.addGestureRecognizer(tapGesture)
        teamAvatar.isUserInteractionEnabled = true
    }
}

private extension NewRchTeamSorScreenTop {
    @objc func avatarImageDidTapped() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async { [ weak self ]  in
            guard let self else {
                return
            }
            self.picker.delegate = self
            self.picker.activityIndicatorDelegate = self
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true)
        }
    }
    
    @objc func teamsTextFieldScreenDidChanged() {
        guard let name = nameTextField.text?.replacingOccurrences(of: " ", with: ""),
              let numberPhone = contactNumberTextField.text?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        saveButton.isEnabled = !name.isEmpty && !numberPhone.isEmpty
    }
    
    @objc func addAttributedDidTapped() {
        DispatchQueue.main.async { [ weak self ] in
            self?.addAttributeBrandAlert()
        }
    }
    
    @objc func deleteDidTapped() {
        DispatchQueue.main.async { [ weak self ] in
            self?.deleteAlert(with: self?.currentTeam)
        }
    }
    
    @objc func saveDidTapped() {
        
        guard let name = nameTextField.text,
              let phoneNumber = contactNumberTextField.text else {
            return
        }
        
        let newTeam: SorTeamRch
        
        if let coverTeamsData {
            let imageName = newTeamVm.saveImage(from: coverTeamsData)
            newTeam = SorTeamRch(imageName: imageName,
                           teamName: name,
                           phoneNumber: phoneNumber,
                           brandAttributes: self.newTeamVm.attributes)
        } else {
            newTeam = SorTeamRch(imageName: currentTeam?.imageName ?? "",
                           teamName: name,
                           phoneNumber: phoneNumber,
                           brandAttributes: self.newTeamVm.attributes)
        }
        
        if let currentTeam {
            sportsTeamDelegate?.update(oldValue: currentTeam, for: newTeam)
        } else {
            sportsTeamDelegate?.add(new: newTeam)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension NewRchTeamSorScreenTop: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newTeamVm.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TeamAttributesTroTableViewCellRch.self)", for: indexPath) as? TeamAttributesTroTableViewCellRch else {
            return UITableViewCell()
        }
        let team = newTeamVm.attributes[indexPath.row]
        cell.teamDelegate = self
        cell.set(team)
        return cell
    }
}

// Picker extension
extension NewRchTeamSorScreenTop: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [ weak self ] in
                guard let self else {
                    return
                }
                teamAvatar.image = image
                coverTeamsData = image.jpegData(compressionQuality: 0.0)
                teamsTextFieldScreenDidChanged()
            }
        }
        picker.dismiss(animated: true)
    }
}

// Delegate
extension NewRchTeamSorScreenTop: TransitObjectsDelegateProtocol {
    func update<T>(oldValue: T, for newValue: T) where T : Decodable, T : Encodable {
        print("MOCK UPDATE")
    }
    
    func add<T>(new: T) where T : Decodable, T : Encodable {
        print("MOCK ADD")
    }
    
    func delete<T>(_ deletingItem: T) where T : Decodable, T : Encodable {
        if let currentAttribute = deletingItem as? SorBrandTopAttributesRchs {
            newTeamVm.delete(currentAttribute)
        }
    }
}

extension NewRchTeamSorScreenTop: CustomErchPickerTroProtolSor {
    func dismisPickerController() {
        DispatchQueue.main.async { [ weak self ] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}

// Alert
private extension NewRchTeamSorScreenTop {
    func deleteAlert(with team: SorTeamRch?) {
        let alertController = UIAlertController(title: "Delete",
                                                message: "Are you sure you want to delete this team?",
                                                preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive) { [ weak self ]  _ in
            guard let self,
                  let team else {
                return
            }
            self.sportsTeamDelegate?.delete(team)
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(startAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func addAttributeBrandAlert() {
        let alertController = UIAlertController(title: "Create",
                                                message: "Enter attributes type (T-shirts/Form)",
                                                preferredStyle: .alert)
        alertController.addTextField()
        
        let closeAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        
        let addAction = UIAlertAction(title: "Add",
                                      style: .default) { [ weak self ]  _ in
            guard let self,
                  let currentAttributes = alertController.textFields?.first?.text else {
                return
            }
            let newAttributes = SorBrandTopAttributesRchs(brandName: currentAttributes,
                                                count: nil)
            
            self.newTeamVm.attributes.append(newAttributes)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

