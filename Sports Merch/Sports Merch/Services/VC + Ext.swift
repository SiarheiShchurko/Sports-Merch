import UIKit

// MARK: - OpenVC
extension UIViewController {
    func openRamsSheetsArt(vc: UIViewController) {
        if #available(iOS 15.0, *) {
            let sheet = vc.sheetPresentationController
            sheet?.detents = [.medium()]
            sheet?.prefersGrabberVisible = true
        }
        present(vc, animated: true, completion: nil)
    }
    
    func openArtFullRams(vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func openRamsGrabberTra(vc: UIViewController) {
        if #available(iOS 15.0, *) {
            vc.sheetPresentationController?.prefersGrabberVisible = true
        }
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - Make secure
extension UIView {
    func makeRamsSecureArt() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}
