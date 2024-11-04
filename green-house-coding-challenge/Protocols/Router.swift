
import SwiftUI

protocol Router {
    associatedtype Route
    
    var navigationPath: NavigationPath { get }
    func process(route: Route)
    func pop()
}

// MARK: - Routers

protocol AppRouter: Router where Route == AppTransition { }
