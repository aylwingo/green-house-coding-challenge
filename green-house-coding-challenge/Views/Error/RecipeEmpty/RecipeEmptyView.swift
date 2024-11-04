
import SwiftUI

private typealias Constants = RecipeEmptyViewConstants

struct RecipeEmptyView: View {
    @State private var isAlertVisible: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            Image(.empty)
                .resizable()
                .frame(width: Constants.Image.size, height: Constants.Image.size)
            
            Text("No recipes available at the moment.")
                .font(.headline)
            
            createRecipeButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .alert("Feature Coming Soon!", isPresented: $isAlertVisible) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // MARK: - Components
    
    private var createRecipeButton: some View {
        Button {
            withAnimation {
                isAlertVisible.toggle()
            }
        } label: {
            HStack {
                Image(systemName: Constants.Image.name)
                Text("Create a New Recipe")
            }
            .foregroundStyle(.white)
            .padding(.vertical, Constants.verticalPadding)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(.darkOrange)
            }
        }
    }
}
