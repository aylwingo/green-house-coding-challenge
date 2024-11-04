
import Foundation

/// Example of a mock response struct that conforms to Decodable for testing purposes
struct MockResponse: Codable, Equatable {
    let id: Int
    let name: String
}
