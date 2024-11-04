
import SwiftUI

private enum Constants {
    static let verticalPadding: CGFloat = 5
    static let cornerRadius: CGFloat = 15
    static let horizontalPadding: CGFloat = 20
}

struct CustomButtonStyle: ButtonStyle {
    private let style: ButtonType
    private let image: String?
    private let witdth: CGFloat?
    
    init(style: ButtonType, image: String?, witdth: CGFloat?) {
        self.style = style
        self.image = image
        self.witdth = witdth
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let image {
                Image(systemName: image)
            }
            configuration.label
        }
        .foregroundStyle(style.textColor)
        .frame(maxWidth: witdth)
        .padding(.vertical, Constants.verticalPadding)
        .padding(.horizontal)
        .background(backgroundStyle)
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    @ViewBuilder
    private var backgroundStyle: some View {
        switch style {
            case .fill:
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(style.primaryColor)
            case .border:
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(style.primaryColor)
        }
    }
}
