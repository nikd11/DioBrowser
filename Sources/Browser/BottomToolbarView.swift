import SwiftUI

struct BottomToolbarView: View {
    let goBack: () -> Void
    let goForward: () -> Void
    let reload: () -> Void
    let addTab: () -> Void
    @Binding var showTabs: Bool
    
    var body: some View {
        HStack {
            // Back
            ToolbarButton(icon: "chevron.left", action: goBack)
            
            Spacer()
            
            // Forward
            ToolbarButton(icon: "chevron.right", action: goForward)
            
            Spacer()
            
            // Reload
            ToolbarButton(icon: "arrow.clockwise", action: reload)
            
            Spacer()
            
            // Tabs
            Button(action: { showTabs = true }) {
                Image(systemName: "square.on.square")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            // Add Tab
            Button(action: addTab) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
    }
}

struct ToolbarButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    BottomToolbarView(goBack: {}, 
                      goForward: {}, 
                      reload: {}, 
                      addTab: {},
                      showTabs: .constant(false))
}
