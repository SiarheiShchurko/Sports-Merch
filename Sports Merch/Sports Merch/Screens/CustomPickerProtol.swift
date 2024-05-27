import UIKit

protocol CustomPickerProtol: AnyObject {
    func dismisPickerController()
}

final class RacePickerController: UIImagePickerController {
    
    weak var activityIndicatorDelegate: CustomPickerProtol?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicatorDelegate?.dismisPickerController()
    }
}
