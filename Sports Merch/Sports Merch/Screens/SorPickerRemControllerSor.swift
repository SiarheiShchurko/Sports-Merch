import UIKit

protocol CustomErchPickerTroProtolSor: AnyObject {
    func dismisPickerController()
}

final class SorPickerRemControllerSor: UIImagePickerController {
    
    weak var activityIndicatorDelegate: CustomErchPickerTroProtolSor?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicatorDelegate?.dismisPickerController()
    }
}
