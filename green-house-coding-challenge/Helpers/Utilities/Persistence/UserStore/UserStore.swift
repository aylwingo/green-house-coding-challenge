
import Foundation

final class UserStore: PersistenceLayer {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func retrieve<Item: Codable>(for key: PersistenceKey) async throws -> Item? {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
        
        do {
            return try JSONDecoder().decode(Item.self, from: data)
        } catch {
            throw UserStoreError.decodingFailed(error)
        }
    }
    
    func retrieve<Item: Codable>(for key: PersistenceKey) async throws -> [Item] {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return [] }
        
        do {
            return try JSONDecoder().decode([Item].self, from: data)
        } catch {
            throw UserStoreError.decodingFailed(error)
        }
    }
    
    func remove<Item: Codable & Equatable>(_ value: Item, for key: PersistenceKey) async throws {
        do {
            var favorites: [Item] = try await retrieve(for: key)
            favorites.removeAll(where: { $0 == value })
            try await store(favorites, for: key)
        } catch {
            throw UserStoreError.updateFailed(error)
        }
    }
    
    func remove(for key: PersistenceKey) async throws {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func store<Item: Codable>(_ value: Item, for key: PersistenceKey) async throws {
        do {
            let encodedData = try JSONEncoder().encode(value)
            userDefaults.set(encodedData, forKey: key.rawValue)
        } catch {
            throw UserStoreError.encodingFailed(error)
        }
    }
    
    func store<Item: Codable>(_ value: [Item], for key: PersistenceKey) async throws {
        do {
            let encodedData = try JSONEncoder().encode(value)
            userDefaults.set(encodedData, forKey: key.rawValue)
        } catch {
            throw UserStoreError.encodingFailed(error)
        }
    }
}
