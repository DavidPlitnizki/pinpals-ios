import SwiftUI

struct PinTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String?

    var body: some View {
        HStack(spacing: PinSpacing.space2) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(Color.Pin.neutral600)
                    .font(.system(size: 14))
            }
            TextField(placeholder, text: $text)
                .font(.Pin.body)
        }
        .padding(.horizontal, PinSpacing.space4)
        .padding(.vertical, PinSpacing.space3)
        .background(Color.Pin.white)
        .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
        .overlay {
            RoundedRectangle(cornerRadius: PinRadius.md)
                .strokeBorder(Color.Pin.neutral200, lineWidth: 1)
        }
    }
}

#Preview {
    VStack(spacing: PinSpacing.space3) {
        PinTextField(placeholder: "Search places...", text: .constant(""), icon: "magnifyingglass")
        PinTextField(placeholder: "Meeting name", text: .constant("Weekend Hike"))
    }
    .padding()
    .background(Color.Pin.neutral50)
}
