import SwiftUI

struct URLBarView: View {
    @Binding var url: String
    let isLoading: Bool
    let onGo: () -> Void
    let onStop: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // URL/Search Field
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 14))
                
                TextField("Search or enter URL", text: $url)
                    .font(.system(size: 15))
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .onSubmit(onGo)
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                } else if !url.isEmpty {
                    Button(action: { url = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.system(size: 14))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Go/Stop Button
            Button(action: {
                if isLoading {
                    onStop()
                } else {
                    onGo()
                }
            }) {
                Image(systemName: isLoading ? "xmark" : "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    URLBarView(url: .constant("https://apple.com"), 
               isLoading: false,
               onGo: {},
               onStop: {})
        .padding()
}
