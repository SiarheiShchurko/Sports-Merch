
 protocol TransitObjectsDelegateProtocol: AnyObject {
    func add<T: Codable>(new: T)
    func delete< T: Codable>(_ deletingItem: T)
    func update< T: Codable>(oldValue: T, for newValue: T)
}
