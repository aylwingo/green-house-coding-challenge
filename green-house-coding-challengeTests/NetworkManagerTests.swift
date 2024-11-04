
import XCTest
@testable import green_house_coding_challenge

private enum HttpConstants {
    static let successStatusCode: Int = 200
    static let internalServerErrorCode: Int = 500
}

final class NetworkManagerTests: XCTestCase {

    func testFetchDataSuccess() async throws {
        // Given
        let mockResponse = MockResponse(id: 1, name: "Test Name")
        let networkManager: MockNetworkManagerRepresentable = MockNetworkManager()
        networkManager.mockResponse(model: mockResponse, statusCode: HttpConstants.successStatusCode)

        // When
        let mockResult: MockResponse = try await networkManager.fetchData(from: .allRecipes)

        // Then
        XCTAssertEqual(mockResult, mockResponse)
        XCTAssertEqual(mockResult.id, mockResponse.id)
        XCTAssertEqual(mockResult.name, mockResponse.name)
    }

    func testFetchDataError() async {
        // Given
        var networkManager: MockNetworkManagerRepresentable = MockNetworkManager()
        networkManager.shouldReturnError = true
        networkManager.mockError = NetworkError.invalidURL

        // When / Then
        do {
            let _: MockResponse = try await networkManager.fetchData(from: .allRecipes)
            XCTFail("Expected network error, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidURL.localizedDescription)
        } catch {
            XCTFail("Expected NetworkError.invalidURL, but received a different error: \(error)")
        }
    }

    func testFetchDataNetworkError() async throws {
        // Given
        let mockInvalidData: Data? = "Invalid data".data(using: .utf8)
        let networkManager: MockNetworkManagerRepresentable = MockNetworkManager()
        networkManager.mockResponse(model: mockInvalidData, statusCode: HttpConstants.internalServerErrorCode)

        // When / Then
        do {
            let _: MockResponse = try await networkManager.fetchData(from: .emptyRecipes)
            XCTFail("Expected decoding error, but succeeded")
        } catch {
            XCTAssertEqual(networkManager.statusCode, HttpConstants.internalServerErrorCode)
            XCTAssertTrue(error is DecodingError, "Expected DecodingError but got \(error)")
        }
    }
}
