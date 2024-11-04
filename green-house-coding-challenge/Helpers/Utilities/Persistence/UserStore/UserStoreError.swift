
enum UserStoreError: Error {
    case decodingFailed(Error)
    case encodingFailed(Error)
    case updateFailed(Error)
    
    var localizedDescription: String {
        switch self {
            case .decodingFailed(let error): "Failed to decode data: \(error.localizedDescription)"
            case .encodingFailed(let error): "Failed to encode data: \(error.localizedDescription)"
            case .updateFailed(let error): "Failed to update data: \(error.localizedDescription)"
        }
    }
}
