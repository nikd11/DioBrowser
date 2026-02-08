import SwiftUI
import WebKit

class BrowserManager: ObservableObject {
    @Published var urlText: String = ""
    @Published var isLoading: Bool = false
    @Published var showTabs: Bool = false
    @Published var currentTab: Int = 0
    
    let webView: WKWebView
    private var tabs: [WKWebView] = []
    
    init() {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        // Enable privacy features
        config.websiteDataStore.nonPersistent()
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        
        // Add initial tab
        addTab()
        
        // Load homepage
        loadHomepage()
    }
    
    func loadHomepage() {
        urlText = ""
        if let url = URL(string: "about:blank") {
            webView.load(URLRequest(url: url))
        }
    }
    
    func loadURL() {
        var urlString = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if urlString.isEmpty { return }
        
        // Add protocol if missing
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            // Check if it looks like a domain
            if urlString.contains(".") {
                urlString = "https://" + urlString
            } else {
                // Search query
                urlString = "https://www.google.com/search?q=\(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString)"
            }
        }
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
    
    func stopLoading() {
        webView.stopLoading()
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func reload() {
        webView.reload()
    }
    
    func addTab() {
        let config = WKWebViewConfiguration()
        config.websiteDataStore.nonPersistent()
        
        let newWebView = WKWebView(frame: .zero, configuration: config)
        newWebView.navigationDelegate = self
        
        tabs.append(newWebView)
        currentTab = tabs.count - 1
        
        // Switch to new tab
        if let url = URL(string: "about:blank") {
            newWebView.load(URLRequest(url: url))
        }
    }
    
    func switchToTab(_ index: Int) {
        if index < tabs.count {
            currentTab = index
        }
        showTabs = false
    }
    
    func closeTab(_ index: Int) {
        guard index < tabs.count else { return }
        tabs[index].removeFromSuperview()
        tabs.remove(at: index)
        
        if tabs.isEmpty {
            addTab()
        } else if currentTab >= tabs.count {
            currentTab = tabs.count - 1
        }
    }
}

extension BrowserManager: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
        urlText = webView.url?.absoluteString ?? ""
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
        urlText = webView.url?.absoluteString ?? ""
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoading = false
    }
}
