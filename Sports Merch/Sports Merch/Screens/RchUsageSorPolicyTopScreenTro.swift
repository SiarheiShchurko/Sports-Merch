import UIKit

final class RchUsageSorPolicyTopScreenTro: UIViewController {
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let url: URL
    
    private let customTitle = TroSimpleTroLabelRch(text: "Usage Policy",
                                                 textColor: .black,
                                                 font: .boldSystemFont(ofSize: 17))
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.4)
        
        return view
    }()
    
    var rootView: WeRchViewSecViewTroSor {
        self.view as! WeRchViewSecViewTroSor
    }
    
    override func loadView() {
        self.view = WeRchViewSecViewTroSor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        constraints()
        rootView.startSpinner()
        rootView.webView.load(URLRequest(url: self.url))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.rootView.stopSpinner()
        }
    }
}

// MARK: - Add Subviews and child
private extension RchUsageSorPolicyTopScreenTro {
    func addSubviews() {
        view.addSubview(separatorView)
    }
}

// MARK: - Constraints
private extension RchUsageSorPolicyTopScreenTro {
    func constraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: view.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            rootView.topAnchor.constraint(equalTo: separatorView.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
