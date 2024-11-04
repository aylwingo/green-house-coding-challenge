
import Foundation
import Combine

private enum Constants {
    static let debounceTime: Int = 300
    static let defaultString: String = ""
}

final class HomeViewModel<
    NetworkRepresentable: NetworkManagerRepresentable,
    PersistenceRepresentable: RecipeStoreReprentable
>: HomeViewModelRepresentable {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isFetchInProgress: Bool = false
    @Published private(set) var viewState: HomeViewState = .content
    @Published var searchText: String = Constants.defaultString
    @Published var currentEndpoint: Endpoint = .allRecipes
    @Published var selectedList: RecipeSegment = .recipes
    
    private let networkManager: NetworkRepresentable
    private let recipeStore: PersistenceRepresentable
    private var allRecipes: [Recipe] = []
    private var favoriteRecipes: [Recipe] = []
    private var cancellables = Set<AnyCancellable>()
    
    var isSearchEmptyWithNoResults: Bool {
        recipes.isEmpty && !searchText.isEmpty ||
        selectedList == .favorites && recipes.isEmpty
    }
    
    // MARK: - Initializer
    
    init(networkManager: NetworkRepresentable = NetworkManager(),
         recipeStore: PersistenceRepresentable = RecipeStore()) {
        self.networkManager = networkManager
        self.recipeStore = recipeStore
        fetchRecipes()
        setupBindings()
    }
    
    // MARK: - Functions
    
    func fetchFavorites() {
        Task { @MainActor in
            do {
                let recipes = try await recipeStore.getFavorites()
                favoriteRecipes = recipes.reversed()
                filterRecipes()
            } catch {
                handleError(error)
            }
        }
    }
    
    func fetchRecipes() {
        guard !isFetchInProgress else { return }
        isFetchInProgress.toggle()
        searchText = Constants.defaultString

        Task { @MainActor in
            defer { isFetchInProgress.toggle() }
            
            do {
                let response: BaseRecipe = try await networkManager.fetchData(from: currentEndpoint)
                await handleFetchSuccess(with: response.recipes)
            } catch {
                handleError(error)
            }
        }
    }
    
    @MainActor
    private func handleFetchSuccess(with recipes: [Recipe]) async {
        allRecipes = recipes
        viewState = recipes.isEmpty ? .empty : .content
        fetchFavorites()
    }
    
    private func setupBindings() {
        $searchText
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(Constants.debounceTime), scheduler: DispatchQueue.main)
            .sink { [unowned self] searchText in
                filterRecipes(using: searchText)
            }
            .store(in: &cancellables)
        
        $currentEndpoint
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                fetchRecipes()
            }
            .store(in: &cancellables)
        
        $selectedList
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] selected in
                filterRecipes(with: selected)
            }
            .store(in: &cancellables)
    }
    
    private func filterRecipes(with selected: RecipeSegment? = nil,
                               using text: String? = nil) {
        var filterRecipes: [Recipe] {
            switch selected ?? selectedList {
                case .favorites: favoriteRecipes
                case .recipes: allRecipes
            }
        }
        let searchText = text ?? searchText
        
        recipes = searchText.isEmpty
        ? filterRecipes
        : filterRecipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private func handleError(_ error: Error) {
        var errorMessage: String {
            switch error {
                case let networkError as NetworkError: networkError.localizedDescription
                case let persistenceError as RecipeStoreError: persistenceError.localizedDescription
                default: "Unexpected error: \(error.localizedDescription)"
            }
        }
        debugPrint(errorMessage)
        viewState = .error
        recipes = []
    }
}
