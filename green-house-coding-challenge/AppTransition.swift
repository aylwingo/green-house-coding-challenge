
import Foundation

enum AppTransition: Hashable, Equatable {
    case showHome
    case showDetail(Recipe)
    case showSource(URL)
}
