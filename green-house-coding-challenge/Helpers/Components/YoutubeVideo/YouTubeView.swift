
import SwiftUI
import WebKit

/// Currently, the WKWebView component causes some warnings in versions later than iOS 16.0.
/// According to research conducted, this is a bug introduced by the Apple team,
/// which has not yet provided a concrete response on how to resolve it.
/// Some forums on this topic:
/// - https://stackoverflow.com/questions/50537421/wkwebview-in-ios-app-takes-a-long-time-to-load
/// - https://developer.apple.com/forums/thread/712899?login=true&page=1#726423022

private enum Constants {
    static let pageIdentifier: String = "watch?v="
    static let embedIdentifier: String = "embed/"
}

struct YouTubeView: UIViewRepresentable {
    private let videoUrl: String
    
    init(videoUrl: String) {
        self.videoUrl = videoUrl
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedUrl = videoUrl.replacingOccurrences(
            of: Constants.pageIdentifier,
            with: Constants.embedIdentifier
        )
        guard let url = URL(string: embedUrl) else { return }
        uiView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> YoutubeCoordinator { .init() }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator: YoutubeCoordinator) {
        uiView.stopLoading()
        uiView.navigationDelegate = nil
    }
}

