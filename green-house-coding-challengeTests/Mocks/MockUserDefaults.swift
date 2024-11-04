
import Foundation

final class MockUserDefaults: UserDefaults {
    private var storage = [String: Any]()

    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    override func removeObject(forKey defaultName: String) {
        storage.removeValue(forKey: defaultName)
    }
}
