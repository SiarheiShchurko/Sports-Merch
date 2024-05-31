import UIKit

final class NewTopShopSorScreenRchs: UIViewController {
    init(newShopmVm: NewTopShopRchVmProtocol,
         currentShop: SorShopRchs?,
         picker: SorPickerRemControllerSor) {
        self.newShopmVm = newShopmVm
        self.currentShop = currentShop
        self.picker = picker
        super.init(nibName: nil,
                   bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Property
    weak var sportsShopDelegate: TransitObjectsDelegateProtocol?
    
    private var coverTeamsData: Data?
    private let currentShop: SorShopRchs?
    
    private let newShopmVm: NewTopShopRchVmProtocol
    private let picker: SorPickerRemControllerSor
    
    private lazy var textFieldsArray: [RchUnicalTroTfSor] = [nameTextField, addressTextField, contactNumberTextField]
    
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
    
    private let addressTextField = RchUnicalTroTfSor(placeholder: "Address")
    
    // Stack
    private lazy var textFieldStack = RchUniqueStackRtoViewSor(views: [nameTextField,
                                                                      addressTextField,
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
private extension NewTopShopSorScreenRchs {
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
        
        currentShop != nil ? setEditingItemUI() : setNewItemUI()
    }
    
    func constraints() {
        view.addSubview(teamAvatar)
        view.addSubview(textFieldStack)
        view.addSubview(buttonsStack)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            teamAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            teamAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            teamAvatar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            teamAvatar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),
            
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            addressTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            contactNumberTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            
            textFieldStack.topAnchor.constraint(equalTo: teamAvatar.bottomAnchor, constant: 16),
            textFieldStack.leadingAnchor.constraint(equalTo: teamAvatar.leadingAnchor),
            textFieldStack.trailingAnchor.constraint(equalTo: teamAvatar.trailingAnchor),
            
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
        
        if let currentShop {
            
            nameTextField.text = currentShop.shopName
            addressTextField.text = currentShop.address
            contactNumberTextField.text = currentShop.phoneNumber
            
            if currentShop.imageName == "defaultShopImg" {
                teamAvatar.image = UIImage(named: "defaultShopImg")
            } else if let imageDta = newShopmVm.loadImage(with: currentShop.imageName) {
                teamAvatar.image = UIImage(data: imageDta)
            } else {
                teamAvatar.image = UIImage(named: "emptyStrAvatarEchImg")
            }
        }
    }
}

private extension NewTopShopSorScreenRchs {
    func newTeamTargets() {
        deleteButton.addTarget(self, action: #selector(deleteDidTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        textFieldsArray.forEach({ $0.addTarget(self, action: #selector(teamsTextFieldScreenDidChanged), for: .editingChanged) })
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageDidTapped))
        teamAvatar.addGestureRecognizer(tapGesture)
        teamAvatar.isUserInteractionEnabled = true
    }
}

private extension NewTopShopSorScreenRchs {
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
    
    @objc func deleteDidTapped() {
        DispatchQueue.main.async { [ weak self ] in
            self?.deleteAlert(with: self?.currentShop)
        }
    }
    
    @objc func saveDidTapped() {
        
        guard let name = nameTextField.text,
              let phoneNumber = contactNumberTextField.text,
              let address = addressTextField.text else {
            return
        }
        
        let newShop: SorShopRchs
        
        if let coverTeamsData {
            let imageName = newShopmVm.saveImage(from: coverTeamsData)
            newShop = SorShopRchs(imageName: imageName,
                           shopName: name,
                           phoneNumber: phoneNumber,
                           brandName: currentShop?.brandName ?? [],
                           address: address)
        } else {
            newShop = SorShopRchs(imageName: currentShop?.imageName ?? "",
                           shopName: name,
                           phoneNumber: phoneNumber,
                           brandName: currentShop?.brandName ?? [],
                           address: address)
        }
        
        if let currentShop {
            sportsShopDelegate?.update(oldValue: currentShop, for: newShop)
        } else {
            sportsShopDelegate?.add(new: newShop)
        }
        navigationController?.popViewController(animated: true)
    }
}



// Picker extension
extension NewTopShopSorScreenRchs: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//extension NewShopScreen: TransitObjectsDelegateProtocol {
//    func update<T>(oldValue: T, for newValue: T) where T : Decodable, T : Encodable {
//        print("MOCK UPDATE")
//    }
//    
//    func add<T>(new: T) where T : Decodable, T : Encodable {
//        print("MOCK ADD")
//    }
//    
//    func delete<T>(_ deletingItem: T) where T : Decodable, T : Encodable {
//        if let currentAttribute = deletingItem as? BrandAttributes {
//            newShopmVm.delete(currentAttribute)
//        }
//    }
//}

extension NewTopShopSorScreenRchs: CustomErchPickerTroProtolSor {
    func dismisPickerController() {
        DispatchQueue.main.async { [ weak self ] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}

// Alert
private extension NewTopShopSorScreenRchs {
    func deleteAlert(with shop: SorShopRchs?) {
        let alertController = UIAlertController(title: "Delete",
                                                message: "Are you sure you want to delete this shop?",
                                                preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive) { [ weak self ]  _ in
            guard let self,
                  let shop else {
                return
            }
            self.sportsShopDelegate?.delete(shop)
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(startAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

