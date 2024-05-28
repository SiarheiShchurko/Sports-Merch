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

extension UIView {
    func hideKeyboard(exclude viewsToExclude: [UIView] = []) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
        for view in viewsToExclude {
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnExcludedView(_:))))
        }
    }
    @objc private func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if !isTappingOnExcludedView(gesture.location(in: self)),
            let topSuperview {
                topSuperview.endEditing(true)
            }
        }
    }
    @objc private func tapOnExcludedView(_ gesture: UITapGestureRecognizer) {
    }
    private func isTappingOnExcludedView(_ location: CGPoint) -> Bool {
        for recognizer in gestureRecognizers ?? [] {
            if let tapRecognizer = recognizer as? UITapGestureRecognizer,
               tapRecognizer.view != self {
                let locationInView = tapRecognizer.location(in: self)
                if bounds.contains(locationInView) {
                    return true
                }
            }
        }
        return false
    }
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
}
