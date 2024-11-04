
import SwiftUI

extension View {
    /// Customizes the appearance of the search field,
    /// as there are currently no customization options in SwiftUI.
    func customizedSearch() -> some View {
        onAppear {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
        }
    }
}
