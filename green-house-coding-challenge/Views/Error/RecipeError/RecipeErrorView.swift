
import SwiftUI

private typealias Constants = RecipeErrorViewConstants

struct RecipeErrorView: View {
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            Image(.wrong)
                .resizable()
                .frame(width: Constants.Image.size, height: Constants.Image.size)
            
            Text("Something went wrong")
                .font(.headline)
            
            tryAgainButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private var tryAgainButton: some View {
        Button {
            // TODO: - Add Action
        } label: {
            HStack {
                Image(systemName: Constants.Image.name)
                Text("Try again")
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
