
import SwiftUI

private typealias Constants = RecipeItemConstants

struct RecipeItem: View {
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack {
            RecipeImage(url: recipe.photoUrlLarge, size: Constants.Image.size)
            
            Text(recipe.name)
                .font(.footnote.bold())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            HStack {
                playButton
                
                Text(recipe.cuisine)
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.height)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.customWhite)
        }
    }
    
    // MARK: - Components
    
    private var playButton: some View {
        Label("Play", systemImage: Constants.Button.playImage)
            .font(.subheadline)
            .padding(.vertical, Constants.Button.verticalPadding)
            .padding(.horizontal)
            .foregroundStyle(.customWhite)
            .background {
                RoundedRectangle(cornerRadius: Constants.Button.cornerRadius)
                    .fill(.darkOrange)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
