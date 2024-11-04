
import Foundation

protocol HomeViewModelRepresentable: ObservableObject {
    var recipes: [Recipe] { get }
    var viewState: HomeViewState { get }
    var isFetchInProgress: Bool { get }
    var isSearchEmptyWithNoResults: Bool { get }
    var searchText: String { get set }
    var currentEndpoint: Endpoint { get set }
    var selectedList: RecipeSegment { get set }
    
    func fetchRecipes()
    func fetchFavorites()
}
