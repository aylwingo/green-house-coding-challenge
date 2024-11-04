
import SwiftUI

private enum Constants {
    static let shadow: CGFloat = 10
    static let placeholderImage: String = "rectangle.on.rectangle.slash.fill"
}

struct RecipeImage: View {
    private let url: String
    private let size: CGFloat
    
    init(url: String, size: CGFloat) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        Group {
            if let imageUrl = URL(string: url) {
                CacheAsyncImage(url: imageUrl)
                    .scaledToFill()
                    .clipShape(Circle())
                    .shadow(radius: Constants.shadow)
            } else {
                Image(systemName: Constants.placeholderImage)
                    .resizable()
            }
        }
        .frame(width: size, height: size)
    }
}
