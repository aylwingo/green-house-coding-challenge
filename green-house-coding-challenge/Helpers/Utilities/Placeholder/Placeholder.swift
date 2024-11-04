
import Foundation

protocol Placeholder {
    static var placeholder: Self { get }
}

extension Recipe: Placeholder {
    static var placeholder: Recipe {
        Recipe(
            id: UUID().uuidString,
            cuisine: "cuisine",
            name: "name",
            photoUrlLarge: "photoUrlLarge",
            photoUrlSmall: "photoUrlSmall",
            sourceUrl: "sourceUrl",
            youtubeUrl: "sourceUrl"
        )
    }
}
