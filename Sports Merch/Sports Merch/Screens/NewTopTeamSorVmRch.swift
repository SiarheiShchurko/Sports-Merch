import Foundation

protocol NewTeamProtocol: AnyObject {
    var attributes: [SorBrandTopAttributesRchs] { get set }
    var updateAttributes: (() -> Void)? { get set }
    
    func saveImage(from data: Data?) -> String
    func loadImage(with name: String) -> Data?
    func delete(_ attribute: SorBrandTopAttributesRchs)
}

final class NewTopTeamSorVmRch: NewTeamProtocol {
    
    var updateAttributes: (() -> Void)?
    
    var attributes: [SorBrandTopAttributesRchs] = [] {
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
extension NewTopTeamSorVmRch {
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
            fileManager.loadSorImageRch(imageName: name) { currentData in
                data = currentData
            }
        }
        return data
    }
}


// Delete brand attribute
extension NewTopTeamSorVmRch {
    func delete(_ attribute: SorBrandTopAttributesRchs) {
        let bufferAttribute = attributes
        attributes = bufferAttribute.filter({ $0 != attribute })
    }
}
