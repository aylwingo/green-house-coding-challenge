
import SwiftUI

extension View {
    func loader(_ isLoading: Bool) -> some View {
        modifier(LoaderModifier(isLoading: isLoading))
    }
}
