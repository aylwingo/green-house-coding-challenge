
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case genericError(Error)
    
    var localizedDescription: String {
        switch self {
            case .invalidURL: "The URL provided was invalid."
            case .invalidResponse: "The response from the server was not valid."
            case .genericError(let error): "An error was occurred: \(error.localizedDescription)"
        }
    }
}
