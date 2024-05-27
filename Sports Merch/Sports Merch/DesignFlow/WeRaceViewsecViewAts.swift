import WebKit
class WeRaceViewsecViewAts: UIView {
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
        return webView
    }()
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        return spinner
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(webView)
        addSubview(spinner)
        setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
