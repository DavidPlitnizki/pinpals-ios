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

#Preview {
    PinCard {
        VStack(alignment: .leading, spacing: PinSpacing.space2) {
            Text("Botanical Gardens")
                .font(.Pin.headline)
                .foregroundStyle(Color.Pin.neutral900)
            Text("1.2 km away")
                .font(.Pin.caption)
                .foregroundStyle(Color.Pin.neutral600)
        }
        .padding(PinSpacing.space4)
    }
    .padding()
    .background(Color.Pin.neutral50)
}
