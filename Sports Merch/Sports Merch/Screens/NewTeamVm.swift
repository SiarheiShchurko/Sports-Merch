import Foundation

protocol NewTeamProtocol: AnyObject {
    var attributes: [BrandAttributes] { get set }
    var receiveImageName: ((String) -> Void)? { get set }
    var updateAttributes: (() -> Void)? { get set }
    
    func saveImage(from data: Data)
}

final class NewTeamVm: NewTeamProtocol {
    var updateAttributes: (() -> Void)?
    
    var receiveImageName: ((String) -> Void)?
    
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

extension NewTeamVm {
    func saveImage(from data: Data) {
        fileManager.saveImage?(data: data, complition: { [ weak self ] name in
            self?.receiveImageName?(name)
        })
    }
}
