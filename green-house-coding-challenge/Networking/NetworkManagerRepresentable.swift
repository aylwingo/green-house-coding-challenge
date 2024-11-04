
protocol NetworkManagerRepresentable {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T
    
    // Additional network functions can be added here if needed
}
