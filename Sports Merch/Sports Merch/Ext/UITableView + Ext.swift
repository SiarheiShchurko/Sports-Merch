import UIKit

extension UITableViewCell: FileManagerServiceProtocol {
    func loadImage(imageName: String, complition: @escaping (Data) -> Void) {
            var directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            directoryPath?.appendPathComponent(imageName)
            
            if let filePath = directoryPath,
                let data = try? Data(contentsOf: filePath) {
                complition(data)
        }
    }
}
