
import SwiftUI

final class AppCoordinator {
    @Published var navigationPath: NavigationPath = .init()
    
    lazy var assosiatedView: some View = {
        HomeView()
    }()
    
    private func getDetailView(for recipe: Recipe) -> some View {
        let viewModel = DetailViewModel(recipe: recipe)
        return DetailView(viewModel: viewModel)
    }
}

// MARK: - Conforming Coodinator

extension AppCoordinator: Coordinator {
    func start() {
        // Implement initial navigation setup here, if needed
    }
    
    @ViewBuilder
    func build(for route: AppTransition) -> some View {
        switch route {
            case .showHome: assosiatedView
            case .showDetail(let recipe): getDetailView(for: recipe)
            case .showSource(let url): SafariView(url: url)
        }
    }
}

// MARK: - Conforming Router

extension AppCoordinator: AppRouter {
    func process(route: AppTransition) {
        navigationPath.append(route)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
}
