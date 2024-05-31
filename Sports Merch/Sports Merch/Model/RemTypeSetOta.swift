struct RemTypeSetOta: Codable {
    let imageName: String
    let itemName: String
}

extension RemTypeSetOta: Equatable {
    static func ==(lhs: RemTypeSetOta, rhs: RemTypeSetOta) -> Bool {
        return lhs.itemName == rhs.itemName &&
               lhs.imageName == rhs.imageName
    }
}
