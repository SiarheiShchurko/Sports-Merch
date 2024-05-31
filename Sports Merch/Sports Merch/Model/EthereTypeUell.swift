struct EthereTypeUell: Codable {
    let imageName: String
    let itemName: String
}

extension EthereTypeUell: Equatable {
    static func ==(lhs: EthereTypeUell, rhs: EthereTypeUell) -> Bool {
        return lhs.itemName == rhs.itemName &&
               lhs.imageName == rhs.imageName
    }
}
