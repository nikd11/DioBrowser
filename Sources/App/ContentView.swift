import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject private var browserManager = BrowserManager()
    @State private var showSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            // URL Bar
            URLBarView(url: $browserManager.urlText, 
                      isLoading: browserManager.isLoading,
                      onGo: { browserManager.loadURL() },
                      onStop: { browserManager.stopLoading() })
                .padding(.horizontal)
                .padding(.vertical, 8)
            
            Divider()
            
            // Web View
            WebView(webView: browserManager.webView)
                .ignoresSafeArea(edges: .bottom)
            
            Divider()
            
            // Bottom Toolbar
            BottomToolbarView(goBack: { browserManager.goBack() },
                            goForward: { browserManager.goForward() },
                            reload: { browserManager.reload() },
                            addTab: { browserManager.addTab() },
                            showTabs: $browserManager.showTabs)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $browserManager.showTabs) {
            TabsView(manager: browserManager)
        }
    }
}

#Preview {
    ContentView()
}
