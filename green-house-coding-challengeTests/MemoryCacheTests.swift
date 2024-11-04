
import XCTest
@testable import green_house_coding_challenge

final class MemoryCacheTests: XCTestCase {

    func testSetAndGetValue() {
        // Given
        let memoryCache = MemoryCache<String, String>()
        let key = "testKey"
        let value = "testValue"

        // When
        memoryCache[key] = value

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertEqual(retrievedValue, value, "The retrieved value should match the stored value.")
    }

    func testRemoveValue() {
        // Given
        let memoryCache = MemoryCache<String, String>()
        let key = "testKey"
        let value = "testValue"

        // When
        memoryCache[key] = value
        memoryCache[key] = nil // Remove the value

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertNil(retrievedValue, "The value should be nil after removal.")
    }

    func testUpdateValue() {
        // Given
        let memoryCache = MemoryCache<String, String>()
        let key = "testKey"
        let initialValue = "initialValue"
        let updatedValue = "updatedValue"

        // When
        memoryCache[key] = initialValue
        memoryCache[key] = updatedValue

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertEqual(retrievedValue, updatedValue, "The retrieved value should reflect the updated value.")
    }

    func testMultipleKeys() {
        // Given
        let memoryCache = MemoryCache<String, String>()
        let firstKey = "firstKey"
        let secondKey = "secondKey"
        let firstValue = "firstValue"
        let secondValue = "secondValue"

        // When
        memoryCache[firstKey] = firstValue
        memoryCache[secondKey] = secondValue

        // Then
        let retrievedValue1 = memoryCache[firstKey]
        let retrievedValue2 = memoryCache[secondKey]

        XCTAssertEqual(retrievedValue1, firstValue, "The retrieved value for firstKey should match firstValue.")
        XCTAssertEqual(retrievedValue2, secondValue, "The retrieved value for secondKey should match secondValue.")
    }

    func testSetAndGetArrayValue() {
        // Given
        let memoryCache = MemoryCache<String, [String]>()
        let key = "arrayKey"
        let value = ["mock", "array", "values"]

        // When
        memoryCache[key] = value

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertEqual(retrievedValue, value, "The retrieved array should match the stored array.")
    }

    // Test setting and retrieving a custom model
    func testSetAndGetCustomModel() {
        // Given
        let memoryCache = MemoryCache<String, MockResponse>()
        let key = "modelKey"
        let value = MockResponse(id: 1, name: "Test Model")

        // When
        memoryCache[key] = value

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertEqual(retrievedValue, value, "The retrieved model should match the stored model.")
    }

    func testUpdateArrayValue() {
        // Given
        let memoryCache = MemoryCache<String, [String]>()
        let key = "arrayKey"
        let initialValue = ["mock", "array", "values"]
        let updatedValue = ["another", "array", "values"]

        // When
        memoryCache[key] = initialValue
        memoryCache[key] = updatedValue

        // Then
        let retrievedValue = memoryCache[key]

        XCTAssertEqual(retrievedValue, updatedValue, "The retrieved array should reflect the updated array.")
    }

    func testRemoveCustomModel() {
        // Given
        let memoryCache = MemoryCache<String, MockResponse>()
        let key = "modelKey"
        let value = MockResponse(id: 2, name: "Removable Model")

        // When
        memoryCache[key] = value
        memoryCache[key] = nil // Remove the model

        // Then
        let retrievedValue = memoryCache[key]
        
        XCTAssertNil(retrievedValue, "The model should be nil after removal.")
    }
}
