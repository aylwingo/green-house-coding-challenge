
import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $appCoordinator.navigationPath) {
            appCoordinator.assosiatedView
                .preferredColorScheme(.light)
                .navigationDestination(for: AppTransition.self) { route in
                    appCoordinator.build(for: route)
                }
        }
    }
}
