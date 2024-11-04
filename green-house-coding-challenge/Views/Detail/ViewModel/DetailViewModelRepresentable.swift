
import Foundation

protocol DetailViewModelRepresentable: ObservableObject {
    var recipe: Recipe { get }
    var isFavorite: Bool { get }
    
    func isFavoriteToggle()
}
