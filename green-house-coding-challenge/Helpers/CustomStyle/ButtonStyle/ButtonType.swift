
import SwiftUI

enum ButtonType {
    case fill, border
    
    var primaryColor: Color { .darkOrange }
    
    var textColor: Color {
        switch self {
            case .fill: .customWhite
            case .border: .darkOrange
        }
    }
}
