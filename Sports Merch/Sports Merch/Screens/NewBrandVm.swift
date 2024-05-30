protocol NewBrandVmProtocol: AnyObject {
    var attributes: [BrandAttributes] { get set }
    var updateAttributes: (() -> Void)? { get set }
    
    func replace(oldAttribute: BrandAttributes, for newAttribute: BrandAttributes)
}

final class NewBrandVm: NewBrandVmProtocol {
    var updateAttributes: (() -> Void)?
    var attributes: [BrandAttributes] = [] {
        didSet {
            updateAttributes?()
        }
    }
}

extension NewBrandVm {
    func replace(oldAttribute: BrandAttributes, for newAttribute: BrandAttributes) {
        var bufferArray = attributes
        attributes.enumerated().forEach { index, value in
           if value == oldAttribute {
               bufferArray[index] = newAttribute
            }
        }
        attributes = bufferArray
    }
}
