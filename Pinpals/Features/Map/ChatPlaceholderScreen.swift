import SwiftUI

struct ChatPlaceholderScreen: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Messages Coming Soon",
                systemImage: "bubble.left.and.bubble.right",
                description: Text("Chat with friends and share your favorite places")
            )
            .navigationTitle("Messages")
        }
    }
}
