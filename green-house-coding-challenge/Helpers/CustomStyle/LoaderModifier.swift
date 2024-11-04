
import SwiftUI

struct LoaderModifier: ViewModifier {
    private let isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
        } else {
            content
        }
    }
}
