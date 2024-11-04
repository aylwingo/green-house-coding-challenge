
import WebKit

final class YoutubeCoordinator: NSObject, WKNavigationDelegate {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        setupActivityIndicator(in: webView)
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func setupActivityIndicator(in webView: WKWebView) {
        guard activityIndicator.superview == nil else { return }
        activityIndicator.center = webView.center
        webView.addSubview(activityIndicator)
    }
}

