
import Foundation

enum AppConfigKey: String {
    case apiUrl = "API_URL"
}

struct AppConfig {
    static let shared: AppConfig = .init()
    private let bundle: Bundle = .main
    
    private init() { }
    
    func infoValue(for key: AppConfigKey) -> String? {
        bundle.object(forInfoDictionaryKey: key.rawValue) as? String
    }
}
