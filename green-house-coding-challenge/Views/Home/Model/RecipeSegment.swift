
enum RecipeSegment: CaseIterable {
    case recipes, favorites
    
    var title: String {
        String(describing: self).capitalized
    }
}
