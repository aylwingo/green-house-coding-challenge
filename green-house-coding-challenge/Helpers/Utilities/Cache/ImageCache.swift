
import SwiftUI

final class ImageCache {
    static let shared: ImageCache = .init()
    private let imageCache = MemoryCache<URL, Image>()
    
    private init() { }
    
    @discardableResult
    func addImage(from url: URL, with image: Image) -> Image {
        imageCache[url] = image
        return image
    }
    
    func getImage(from url: URL) -> Image? {
        imageCache[url]
    }
}
