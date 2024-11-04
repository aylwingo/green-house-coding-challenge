
import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.darkOrange, .customWhite],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
