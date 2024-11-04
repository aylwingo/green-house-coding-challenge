
import SwiftUI

struct CacheAsyncImage: View {
    private let cache: ImageCache = .shared
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let imageCached = cache.getImage(from: url) {
            imageCached
                .resizable()
        } else {
            AsyncImage(url: url) { image in
                cache
                    .addImage(from: url, with: image)
                    .resizable()
            } placeholder: {
                ProgressView()
            }
        }
    }
}
