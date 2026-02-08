import SwiftUI

struct TabsView: View {
    @ObservedObject var manager: BrowserManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<manager.tabs.count, id: \.self) { index in
                    TabRowView(title: manager.tabs[index].url?.absoluteString ?? "New Tab",
                              isSelected: index == manager.currentTab)
                        .onTapGesture {
                            manager.switchToTab(index)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                manager.closeTab(index)
                            } label: {
                                Label("Close", systemImage: "trash")
                            }
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        manager.closeTab(index)
                    }
                }
            }
            .navigationTitle("Tabs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { manager.addTab(); dismiss() }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct TabRowView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "doc.text")
                .foregroundColor(isSelected ? .accentColor : .secondary)
            
            Text(title.isEmpty ? "New Tab" : title)
                .lineLimit(1)
                .foregroundColor(isSelected ? .primary : .secondary)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.vertical, 4)
        .background(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
        .cornerRadius(8)
    }
}

#Preview {
    TabsView(manager: BrowserManager())
}
