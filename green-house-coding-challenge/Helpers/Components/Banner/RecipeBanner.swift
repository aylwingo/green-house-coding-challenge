
import SwiftUI

private typealias Constants = RecipeBannerConstants

struct RecipeBanner: View {
    @Binding private var selectedList: RecipeSegment
    
    init(selectedList: Binding<RecipeSegment>) {
        _selectedList = selectedList
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Find your food recipe easily")
                    .font(.title2)
                
                recipeButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            bannerImage
        }
        .frame(maxWidth: .infinity, maxHeight: Constants.maxHeight)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .padding(.horizontal)
    }
    
    // MARK: - Components
    
    private var recipeButton: some View {
        Button("Go to recipes") {
            selectedList = .recipes
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
        .padding(.vertical, Constants.Button.verticalPadding)
        .foregroundStyle(.darkOrange)
        .background {
            RoundedRectangle(cornerRadius: Constants.Button.cornerRadius)
                .fill(.lightOrange)
        }
    }
    
    private var bannerImage: some View {
        Image(.banner)
            .resizable()
            .scaledToFit()
            .frame(height: Constants.Image.height)
            .background(backgroundImage)
    }
    
    private var backgroundImage: some View {
        Ellipse()
            .fill(.lightOrange)
            .frame(
                width: Constants.Image.backgroundWidth,
                height: Constants.Image.backgroundHeight
            )
            .offset(x: Constants.Image.backgroundOffset)
    }
}

