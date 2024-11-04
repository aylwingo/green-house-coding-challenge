
import SwiftUI

extension View {
    func buttonStyle(style: ButtonType,
                     image: String? = nil,
                     witdth: CGFloat? = nil) -> some View {
        buttonStyle(
            CustomButtonStyle(
                style: style,
                image: image,
                witdth: witdth
            )
        )
    }
}
