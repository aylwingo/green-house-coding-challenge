
import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype SomeView: View
    
    var assosiatedView: SomeView { get }
    func start()
}
