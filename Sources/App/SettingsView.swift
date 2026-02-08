import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("enableAdBlocker") var enableAdBlocker = true
    @AppStorage("enableNightMode") var enableNightMode = false
    @AppStorage("clearOnExit") var clearOnExit = false
    
    var body: some View {
        NavigationView {
            List {
                // Privacy Section
                Section("Privacy") {
                    Toggle("Enable Ad Blocker", isOn: $enableAdBlocker)
                    Toggle("Clear History on Exit", isOn: $clearOnExit)
                }
                
                // Appearance Section
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $enableNightMode)
                }
                
                // About Section
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Build")
                        Spacer()
                        Text("1")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Info Section
                Section("Features") {
                    Text("Light Browser is a fast, privacy-focused web browser with minimal design and ad-blocking capabilities.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
