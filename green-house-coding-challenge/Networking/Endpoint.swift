
import Foundation

enum Endpoint {
    case allRecipes
    case emptyRecipes
    case malformedRecipes
    
    var url: String? {
        guard let baseUrl = AppConfig.shared.infoValue(for: .apiUrl) else { return nil }
        return "\(baseUrl)\(path)"
    }
    
    private var path: String {
        switch self {
            case .allRecipes: "/recipes.json"
            case .emptyRecipes: "/recipes-empty.json"
            case .malformedRecipes: "/recipes-malformed.json"
        }
    }
}
