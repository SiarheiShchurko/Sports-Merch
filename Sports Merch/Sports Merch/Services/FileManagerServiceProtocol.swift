import UIKit

@objc protocol FileManagerServiceProtocol: AnyObject {
    @objc optional func saveImage(data: Data, complition: @escaping (String) -> Void)
    func loadImage(imageName: String, complition: @escaping (Data) -> Void)
}

final class FileManagerService: FileManagerServiceProtocol {
        
    func saveImage(data: Data, complition: @escaping (String) -> Void) {
            
            var directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let localName = "SportsMerch - \(Date().timeIntervalSince1970).jpg"
            
                directoryPath?.appendPathComponent(localName)
            if let filePath = directoryPath {
                try? data.write(to: filePath)
                complition(localName)
        }
    }
    
    func loadImage(imageName: String, complition: @escaping (Data) -> Void) {
            var directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            directoryPath?.appendPathComponent(imageName)
            
            if let filePath = directoryPath,
                let data = try? Data(contentsOf: filePath) {
                complition(data)
        }
    }
}

