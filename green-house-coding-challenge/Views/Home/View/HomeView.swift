
import SwiftUI

private typealias Constants = HomeViewConstants

struct HomeView<ViewModel: HomeViewModelRepresentable>: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject private var viewModel: ViewModel
    
    private let columns: [GridItem] =  Array(
        repeating: .init(spacing: Constants.containerSpacing),
        count: Constants.itemCount
    )
    
    init(viewModel: ViewModel = HomeViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: Constants.containerSpacing) {
            contentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundGradient())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Recipes")
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                dataOptionMenu
            }
        }
    }
    
    // MARK: - Components
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.viewState {
            case .error: RecipeErrorView()
            case .empty: RecipeEmptyView()
            case .content: listView
        }
    }
    
    private var listView: some View {
        VStack {
            RecipeBanner(selectedList: $viewModel.selectedList)
            
            pickerView
            
            ScrollView(showsIndicators: false) {
                if viewModel.isSearchEmptyWithNoResults {
                    emptyMessage
                } else {
                    recipeGridView
                }
            }
            .scrollDisabled(viewModel.isSearchEmptyWithNoResults)
            .loader(viewModel.isFetchInProgress)
            .onAppear(perform: viewModel.fetchFavorites)
            .refreshable {
                viewModel.fetchRecipes()
            }
        }
        .searchable(text: $viewModel.searchText)
        .customizedSearch()
    }
    
    private var emptyMessage: some View {
        Text("No recipes found. It looks like there are no matching results at the moment.")
            .multilineTextAlignment(.center)
            .padding(Constants.messagePadding)
    }

    private var recipeGridView: some View {
        LazyVGrid(columns: columns, spacing: Constants.containerSpacing) {
            ForEach(viewModel.isFetchInProgress ? loadingList : viewModel.recipes) { recipe in
                Button(action: { appCoordinator.process(route: .showDetail(recipe)) }) {
                    RecipeItem(recipe: recipe)
                }
                .buttonStyle(.plain)
                .animation(.easeInOut, value: viewModel.recipes)
            }
        }
        .padding(.horizontal)
    }
    
    private var dataOptionMenu: some View {
        Menu("", systemImage: Constants.menuImage) {
            ForEach(DataOption.allCases) { option in
                Button(option.title) {
                    withAnimation {
                        viewModel.currentEndpoint = option.associatedEndpoint
                    }
                }
            }
        }
        .tint(.white)
    }
    
    private var pickerView: some View {
        Picker("", selection: $viewModel.selectedList) {
            ForEach(RecipeSegment.allCases, id: \.self) { segment in
                Text(segment.title)
            }
        }
        .pickerStyle(.segmented)
        .background {
            RoundedRectangle(cornerRadius: Constants.Picker.cornerRadius)
                .fill(.customWhite.opacity(Constants.Picker.opacity))
        }
        .padding(.horizontal)
    }
    
    private var loadingList: [Recipe] {
        (.zero...Constants.maxLoadingList).map { _ in Recipe.placeholder }
    }
}
