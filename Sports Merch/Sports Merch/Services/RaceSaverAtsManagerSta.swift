import Foundation

final class RaceSaverAtsManagerSta<T: Codable> {
    
    private let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func saveModel(_ model: T, key: String) {
        var models = getModels(with: key)
        models.append(model)
        saveModels(models, key: key)
    }
    
    func getModels(with key: String) -> [T] {
        guard let modelData = userDefaults.array(forKey: key) as? [Data] else {
            return []
        }
        
        let models = modelData.compactMap { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return models
    }
    
    func saveModels(_ models: [T], key: String) {
        let modelData = models.compactMap { model -> Data? in
            return try? JSONEncoder().encode(model)
        }
        
        userDefaults.set(modelData, forKey: key)
        userDefaults.synchronize()
    }
    
    func removeModel(with key: String, index: Int) {
        var models = getModels(with: key)
        
        guard index >= 0 && index < models.count else {
            return
        }
        
        models.remove(at: index)
        saveModels(models, key: key)
    }
    
    func clearAllModels() {
        if let appDomain = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: appDomain)
            userDefaults.synchronize()
        }
    }
}
