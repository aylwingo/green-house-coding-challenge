
enum DataOption: Int, Identifiable, CaseIterable {
    case success, empty, malformed
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
            case .success: "All recipes"
            case .empty: "Empty recipes"
            case .malformed: "Malformed recipes"
        }
    }
    
    var associatedEndpoint: Endpoint {
        switch self {
            case .success: .allRecipes
            case .empty: .emptyRecipes
            case .malformed: .malformedRecipes
        }
    }
}
