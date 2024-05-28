
 protocol TransitObjectsDelegateProtocol: AnyObject {
    func add<T: Codable>(new: T)
    func delete< T: Codable>(_ attribute: T)
    func update< T: Codable>(oldTeam: T, for newTeam: T)
}
