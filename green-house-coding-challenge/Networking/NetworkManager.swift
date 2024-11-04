
import Foundation

final class NetworkManager: NetworkManagerRepresentable {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let urlString = endpoint.url,
              let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.genericError(error)
        }
    }
}
