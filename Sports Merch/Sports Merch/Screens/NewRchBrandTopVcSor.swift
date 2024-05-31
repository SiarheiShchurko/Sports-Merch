import UIKit

final class NewRchBrandTopVcSor: UIViewController {
    init(currentBrand: SorBrandRchsNameTro?,
         newBrandVm: NewRchBrandVmProtocolSor) {
        self.currentBrand = currentBrand
        self.newBrandVm = newBrandVm
        super.init(nibName: nil,
                   bundle: nil)
         updateVmParams()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var sportsShopDelegate: TransitObjectsDelegateProtocol?
    private let currentBrand: SorBrandRchsNameTro?
    private let newBrandVm: NewRchBrandVmProtocolSor
    
    // Labels
    private let titleLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "",
                                                                    font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                                    textAlignment: .center)
    
    private let brandNameLabel: TroSimpleTroLabelRch = TroSimpleTroLabelRch(text: "\nBrand name:",
                                                                        font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                                        textAlignment: .left)
    // Buttons
    private let addAttributeButton = ImageRchTitleRtoButtonTro(titleButton: "+ Add attribute",
                                                      colorButton: .white,
                                                      fontButton: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize))
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
    private let nameTextField = RchUnicalTroTfSor(placeholder: "Brand name")
    
    // Table view
    private let attributeTableView = TroTableOrtViewRch(color: .white,
                                                   registerClass: ShopAttributesRtoTableViewCellRch.self,
                                                   cell: "\(ShopAttributesRtoTableViewCellRch.self)",
                                                   rowHeigh: UITableView.automaticDimension,
                                                   separatorStyle: .none)
    // Stack
    private lazy var buttonsStack = RchUniqueStackRtoViewSor(views: [deleteButton,
                                                                    saveButton],
                                                            axis: .horizontal,
                                                            alignment: .fill,
                                                            distribution: .fillEqually,
                                                            spacing: 16)
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewBrandVc()
        newBrandTargets()
        setNewBrandContraints()
    }
}

private extension NewRchBrandTopVcSor {
    func updateVmParams() {
        newBrandVm.updateAttributes = { [ weak self ] in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                self.attributeTableView.reloadData()
                self.teamsTextFieldScreenDidChanged()
            }
        }
    }
}

private extension NewRchBrandTopVcSor {
    func newBrandTargets() {
        deleteButton.addTarget(self, action: #selector(deleteDidTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        addAttributeButton.addTarget(self, action: #selector(addAttributedDidTapped), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(teamsTextFieldScreenDidChanged), for: .editingChanged)
    }
}

private extension NewRchBrandTopVcSor {
    @objc func teamsTextFieldScreenDidChanged() {
        guard let name = nameTextField.text?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        saveButton.isEnabled = !name.isEmpty
    }
    
    @objc func addAttributedDidTapped() {
        DispatchQueue.main.async { [ weak self ] in
            self?.addAttributeBrandAlert()
        }
    }
    
    @objc func deleteDidTapped() {
        DispatchQueue.main.async { [ weak self ] in
            self?.deleteAlert(with: self?.currentBrand)
        }
    }
    
    @objc func saveDidTapped() {
        guard let name = nameTextField.text else {
            return
        }
        
        let newBrand: SorBrandRchsNameTro = SorBrandRchsNameTro(brandName: name,
                                            brandAttributes: newBrandVm.attributes)
        
        print("New brand\(newBrand)")
        
        if let currentBrand {
            print("currentBrand\(currentBrand)")
            sportsShopDelegate?.update(oldValue: currentBrand, for: newBrand)
        } else {
            sportsShopDelegate?.add(new: newBrand)
        }
        dismiss(animated: true)
    }
}

private extension NewRchBrandTopVcSor {
    func setNewBrandVc() {
        view.backgroundColor = .white
        view.hideRchKeyboardTop()
        
        attributeTableView.dataSource = self
        attributeTableView.delegate = self
        
        nameTextField.layer.borderColor = UIColor.appPrimaryColor.cgColor
        nameTextField.layer.borderWidth = 1.0
        
        currentBrand != nil ? setEditingItemUI() : setNewItemUI()
    }
    
    func setNewItemUI() {
        saveButton.setTitle("Add", for: .normal)
        titleLabel.text = "Create"
        deleteButton.isHidden = true
    }
    
    func setEditingItemUI() {
        saveButton.setTitle("Save", for: .normal)
        titleLabel.text = "Edit"
        
        if let currentBrand {
            nameTextField.text = currentBrand.brandName
            newBrandVm.attributes = currentBrand.brandAttributes
        }
    }
    
    func setNewBrandContraints() {
        view.addSubview(titleLabel)
        view.addSubview(brandNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(addAttributeButton)
        view.addSubview(attributeTableView)
        view.addSubview(buttonsStack)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            brandNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            brandNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            brandNameLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: brandNameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            addAttributeButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            addAttributeButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addAttributeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            attributeTableView.topAnchor.constraint(equalTo: addAttributeButton.bottomAnchor, constant: 8),
            attributeTableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            attributeTableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            attributeTableView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -8),
            
            buttonsStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            buttonsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension NewRchBrandTopVcSor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newBrandVm.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopAttributesRtoTableViewCellRch.self)", for: indexPath) as? ShopAttributesRtoTableViewCellRch else {
            return UITableViewCell()
        }
        let team = newBrandVm.attributes[indexPath.row]
        cell.set(team)
        return cell
    }
}

extension NewRchBrandTopVcSor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentAttribute = newBrandVm.attributes[indexPath.row]
        editAttributeBrandAlert(brandAttributes: currentAttribute)
    }
}

// Alerts
private extension NewRchBrandTopVcSor {
    func addAttributeBrandAlert() {
        let alertController = UIAlertController(title: "Create",
                                                message: "Enter attribute parameters",
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()
        
        var counter: Int = 0
        alertController.textFields?.forEach({ textField in
            
            counter == 1 ? (textField.keyboardType = .numberPad) : ()
            
            counter == 0 ? (textField.placeholder = "Name") : (textField.placeholder = "Count")
          
            counter += 1
        })
        
        let closeAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        
        let addAction = UIAlertAction(title: "Add",
                                      style: .default) { [ weak self ]  _ in
            guard let self,
                  let currentAttributes = alertController.textFields?.first?.text,
                  let currentCount = alertController.textFields?.last?.text else {
                return
            }
            let currentIntCount: Int = Int(currentCount) ?? 0
            let newAttributes = SorBrandTopAttributesRchs(brandName: currentAttributes,
                                                count: currentIntCount)
            
            self.newBrandVm.attributes.append(newAttributes)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func editAttributeBrandAlert(brandAttributes: SorBrandTopAttributesRchs) {
        let alertController = UIAlertController(title: "Edit",
                                                message: "Edit attributes",
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()
        
        var counter: Int = 0
        alertController.textFields?.forEach({ textField in
            
            counter == 1 ? (textField.keyboardType = .decimalPad) : ()
            counter == 0 ? (textField.placeholder = "Name") : (textField.placeholder = "Count")
            
            counter == 0 ? (textField.text = brandAttributes.brandName) : (textField.text = "\(brandAttributes.count ?? 0)")

            counter += 1
        })
        
        let closeAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        
        let addAction = UIAlertAction(title: "Save",
                                      style: .default) { [ weak self ]  _ in
            guard let self,
                  let currentAttributes = alertController.textFields?.first?.text,
                  let currentCount = alertController.textFields?.last?.text else {
                return
            }
            
            let currentIntCount: Int = Int(currentCount) ?? 0
            let newAttributes = SorBrandTopAttributesRchs(brandName: currentAttributes,
                                                count: currentIntCount)
            
            self.newBrandVm.replace(oldAttribute: brandAttributes, for: newAttributes)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteAlert(with brand: SorBrandRchsNameTro?) {
        let alertController = UIAlertController(title: "Delete",
                                                message: "Are you sure you want to delete this brand from current shop?",
                                                preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Close",
                                        style: .cancel,
                                        handler: nil)
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive) { [ weak self ]  _ in
            guard let self,
                  let brand else {
                return
            }
            self.sportsShopDelegate?.delete(brand)
            self.dismiss(animated: true)
        }
        
        alertController.addAction(startAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

