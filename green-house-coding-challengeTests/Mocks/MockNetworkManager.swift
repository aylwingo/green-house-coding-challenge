
import Foundation
@testable import green_house_coding_challenge

// MARK: - Mock network manager representable

protocol MockNetworkManagerRepresentable: NetworkManagerRepresentable {
    var shouldReturnError: Bool { get set }
    var mockData: Data? { get set }
    var mockError: Error? { get set }
    var statusCode: Int { get set }

    func mockResponse<T: Encodable>(model: T, statusCode: Int)
}

// MARK: - Mock network manager

final class MockNetworkManager: MockNetworkManagerRepresentable {
    var mockData: Data?
    var mockError: Error?
    var statusCode: Int = 200
    var shouldReturnError = false

    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        if shouldReturnError {
            guard let mockError else { throw MockError.customError }
            throw mockError
        }

        guard let mockData else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: mockData)
    }

    func mockResponse<T: Encodable>(model: T, statusCode: Int = 200) {
        let encoder = JSONEncoder()
        self.mockData = try? encoder.encode(model)
        self.statusCode = statusCode
    }
}
