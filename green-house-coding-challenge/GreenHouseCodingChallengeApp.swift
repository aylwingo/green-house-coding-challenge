
import SwiftUI

@main
struct GreenHouseCodingChallengeApp: App {
    @ObservedObject private var appCoordinator: AppCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appCoordinator)
        }
    }
}
