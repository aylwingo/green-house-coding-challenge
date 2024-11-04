
protocol RecipeStoreReprentable {
    func addFavorite(with recipe: Recipe) async throws
    func removeFavorite(for recipe: Recipe) async throws
    func getFavorites() async throws -> [Recipe]
    func isRecipeFavorite(recipe: Recipe) async -> Bool
}
