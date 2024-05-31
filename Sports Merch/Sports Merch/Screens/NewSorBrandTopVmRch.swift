protocol NewRchBrandVmProtocolSor: AnyObject {
    var attributes: [SorBrandTopAttributesRchs] { get set }
    var updateAttributes: (() -> Void)? { get set }
    
    func replace(oldAttribute: SorBrandTopAttributesRchs, for newAttribute: SorBrandTopAttributesRchs)
}

final class NewSorBrandTopVmRch: NewRchBrandVmProtocolSor {
    var updateAttributes: (() -> Void)?
    var attributes: [SorBrandTopAttributesRchs] = [] {
        didSet {
            updateAttributes?()
        }
    }
}

extension NewSorBrandTopVmRch {
    func replace(oldAttribute: SorBrandTopAttributesRchs, for newAttribute: SorBrandTopAttributesRchs) {
        var bufferArray = attributes
        attributes.enumerated().forEach { index, value in
           if value == oldAttribute {
               bufferArray[index] = newAttribute
            }
        }
        attributes = bufferArray
    }
}
