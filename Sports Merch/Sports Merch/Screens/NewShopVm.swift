import Foundation

protocol NewShopProtocol: AnyObject {
    var attributes: [BrandAttributes] { get set }
    var updateAttributes: (() -> Void)? { get set }
    
    func saveImage(from data: Data?) -> String
    func loadImage(with name: String) -> Data?
   // func delete(_ attribute: BrandAttributes)
}

final class NewShopVm: NewShopProtocol {
    
    var updateAttributes: (() -> Void)?
    
    var attributes: [BrandAttributes] = [] {
        didSet {
            updateAttributes?()
        }
    }
    
    init(fileManager: FileManagerServiceProtocol) {
        self.fileManager = fileManager
    }
    
    private let fileManager: FileManagerServiceProtocol
    
    
}

// Image saver
extension NewShopVm {
    func saveImage(from data: Data?) -> String {
        var imageName: String = ""
        
        if let data {
            fileManager.saveImage?(data: data, complition: { name in
                imageName = name
            })
        }
        return imageName
    }
    
    func loadImage(with name: String) -> Data? {
        var data: Data? = nil
        
        if !name.isEmpty {
            fileManager.loadImage(imageName: name) { currentData in
                data = currentData
            }
        }
        return data
    }
}


// Delete brand attribute
extension NewShopVm {
    func delete(_ attribute: BrandAttributes) {
        let bufferAttribute = attributes
        attributes = bufferAttribute.filter({ $0 != attribute })
    }
}
