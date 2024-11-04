
import XCTest
@testable import green_house_coding_challenge

final class UserStoreTests: XCTestCase {

    func testStoreAndRetrieveSingleItem() async throws {
        // Given
        let mockUserDefaults = MockUserDefaults()
        let userStore = UserStore(userDefaults: mockUserDefaults)
        let key: PersistenceKey = .favoriteRecipes
        let item = MockResponse(id: 1, name: "Test Item")

        // When
        try await userStore.store(item, for: key)
        let retrievedItem: MockResponse? = try await userStore.retrieve(for: key)

        // Then
        XCTAssertEqual(retrievedItem, item, "The retrieved item should match the stored item.")
    }

    func testStoreAndRetrieveArray() async throws {
        // Given
        let mockUserDefaults = MockUserDefaults()
        let userStore = UserStore(userDefaults: mockUserDefaults)
        let key: PersistenceKey = .favoriteRecipes
        let items = [MockResponse(id: 1, name: "Test Item 1"), MockResponse(id: 2, name: "Test Item 2")]

        // When
        try await userStore.store(items, for: key)
        let retrievedItems: [MockResponse] = try await userStore.retrieve(for: key)

        // Then
        XCTAssertEqual(retrievedItems, items, "The retrieved array should match the stored array.")
    }

    func testRemoveItemFromArray() async throws {
        // Given
        let mockUserDefaults = MockUserDefaults()
        let userStore = UserStore(userDefaults: mockUserDefaults)
        let key: PersistenceKey = .favoriteRecipes
        let items = [MockResponse(id: 1, name: "Test Item 1"), MockResponse(id: 2, name: "Test Item 2")]
        try await userStore.store(items, for: key)

        // When
        try await userStore.remove(MockResponse(id: 1, name: "Test Item 1"), for: key)
        let retrievedItems: [MockResponse] = try await userStore.retrieve(for: key)

        // Then
        XCTAssertEqual(retrievedItems, [MockResponse(id: 2, name: "Test Item 2")], "The retrieved array should reflect the removal.")
    }

    func testRemoveAllItemsForKey() async throws {
        // Given
        let mockUserDefaults = MockUserDefaults()
        let userStore = UserStore(userDefaults: mockUserDefaults)
        let key: PersistenceKey = .favoriteRecipes
        let items = [MockResponse(id: 1, name: "Test Item 1"), MockResponse(id: 2, name: "Test Item 2")]
        try await userStore.store(items, for: key)

        // When
        try await userStore.remove(for: key)
        let retrievedItems: [MockResponse] = try await userStore.retrieve(for: key)

        // Then
        XCTAssertTrue(retrievedItems.isEmpty, "The retrieved array should be empty after removal.")
    }

    func testRetrieveNonexistentKey() async throws {
        // Given
        let mockUserDefaults = MockUserDefaults()
        let userStore = UserStore(userDefaults: mockUserDefaults)
        let key: PersistenceKey = .favoriteRecipes

        // When
        let retrievedItem: MockResponse? = try await userStore.retrieve(for: key)

        // Then
        XCTAssertNil(retrievedItem, "The retrieved item should be nil for a nonexistent key.")
    }
}
