
final class RecipeStore<Persistence: PersistenceLayer>: RecipeStoreReprentable {
    private let userStore: Persistence
    
    init(userStore: Persistence = UserStore()) {
        self.userStore = userStore
    }
    
    func addFavorite(with recipe: Recipe) async throws {
        do {
            var favorites: [Recipe] = try await getFavorites()
            favorites.append(recipe)
            try await userStore.store(favorites, for: .favoriteRecipes)
        } catch {
            handleError(error)
            throw RecipeStoreError.failedToAddFavorite
        }
    }
    
    func isRecipeFavorite(recipe: Recipe) async -> Bool {
        do {
            let favorites = try await getFavorites()
            return favorites.contains(recipe)
        } catch {
            handleError(error)
            return false
        }
    }
    
    func getFavorites() async throws -> [Recipe] {
        do {
            return try await userStore.retrieve(for: .favoriteRecipes)
        } catch {
            handleError(error)
            throw RecipeStoreError.failedToRetrieveFavorites
        }
    }
    
    func removeFavorite(for recipe: Recipe) async throws {
        try await userStore.remove(recipe, for: .favoriteRecipes)
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? RecipeStoreError {
            debugPrint(error.localizedDescription)
        } else {
            debugPrint("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
}
