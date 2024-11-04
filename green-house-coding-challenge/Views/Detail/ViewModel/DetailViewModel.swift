
import Foundation

final class DetailViewModel: DetailViewModelRepresentable {
    @Published private(set) var isFavorite: Bool = false
    let recipe: Recipe
    
    private lazy var recipeStore: RecipeStore = .init()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        checkFavorite()
    }
    
    func isFavoriteToggle() {
        Task { @MainActor in
            do {
                isFavorite
                ? try await recipeStore.removeFavorite(for: recipe)
                : try await recipeStore.addFavorite(with: recipe)
                isFavorite.toggle()
            } catch {
                handleError(error)
            }
        }
    }
    
    private func checkFavorite() {
        Task { @MainActor in
            isFavorite = await recipeStore.isRecipeFavorite(recipe: recipe)
        }
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? RecipeStoreError {
            debugPrint(error.localizedDescription)
        } else {
            debugPrint("An unexpected error occurred: \(error.localizedDescription)")
        }
        
        // TODO: - Add Error View
    }
}
