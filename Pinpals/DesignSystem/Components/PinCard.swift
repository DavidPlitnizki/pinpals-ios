import SwiftUI

struct PinCard<Content: View>: View {
    var cornerRadius: CGFloat = PinRadius.lg
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(Color.Pin.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
