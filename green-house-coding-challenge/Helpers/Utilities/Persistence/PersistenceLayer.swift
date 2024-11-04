
protocol PersistenceLayer {
    func retrieve<Item: Codable>(for key: PersistenceKey) async throws -> Item?
    func retrieve<Item: Codable>(for key: PersistenceKey) async throws -> [Item]
    func store<Item: Codable>(_ value: Item, for key: PersistenceKey) async throws
    func store<Item: Codable>(_ value: [Item], for key: PersistenceKey) async throws
    func remove<Item: Codable & Equatable>(_ value: Item, for key: PersistenceKey) async throws
    func remove(for key: PersistenceKey) async throws
}
