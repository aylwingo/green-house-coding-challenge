
enum RecipeStoreError: Error {
    case failedToAddFavorite
    case failedToRetrieveFavorites
    
    var localizedDescription: String {
        switch self {
            case .failedToAddFavorite: "Could not add the recipe to favorites."
            case .failedToRetrieveFavorites: "Unable to retrieve favorite recipes."
        }
    }
}
