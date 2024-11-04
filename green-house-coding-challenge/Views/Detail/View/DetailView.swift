
import SwiftUI

private typealias Constants = DetailViewConstants

struct DetailView<ViewModel: DetailViewModelRepresentable>: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            RecipeImage(url: viewModel.recipe.photoUrlLarge, size: Constants.imageSize)
            
            contentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .background(BackgroundGradient())
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("", systemImage: Constants.backIcon) {
                    appCoordinator.pop()
                }
                .tint(.white)
            }
            
            ToolbarItem(placement: .bottomBar) {
                addToFavoritesButton
            }
        }
    }
    
    // MARK: - Components
    
    private var contentView: some View {
        VStack(spacing: Constants.Content.spacing) {
            Text(viewModel.recipe.name)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            if let youtubeUrl = viewModel.recipe.youtubeUrl {
                YouTubeView(videoUrl: youtubeUrl)
                    .frame(height: Constants.YouTube.height)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.YouTube.cornerRadius))
            }
            
            viewMoreButton
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.Content.padding)
        .background(.customWhite)
        .roundedCorner(
            Constants.Content.roundedCorner,
            corners: [.topLeft, .topRight]
        )
    }
    
    @ViewBuilder
    private var viewMoreButton: some View {
        if let sourceUrl = viewModel.recipe.sourceUrl,
           let url = URL(string: sourceUrl) {
            Button("See more") {
                appCoordinator.process(route: .showSource(url))
            }
            .buttonStyle(style: .border, image: Constants.SeeMore.image)
        }
    }
    
    @ViewBuilder
    private var addToFavoritesButton: some View {
        let imageName: String = viewModel.isFavorite
        ? Constants.FavoriteButton.heartFillImage
        : Constants.FavoriteButton.heartImage
        
        Button(viewModel.isFavorite ? "Remove from favorites" : "Add to favorites") {
            viewModel.isFavoriteToggle()
        }
        .buttonStyle(style: .fill, image: imageName, witdth: .infinity)
    }
}
