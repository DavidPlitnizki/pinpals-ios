import SwiftUI

struct PinChip: View {
    let title: String
    let isSelected: Bool
    var action: (() -> Void)?

    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(.Pin.caption)
                .padding(.horizontal, PinSpacing.space3)
                .padding(.vertical, PinSpacing.space1 + 2)
                .background(isSelected ? Color.Pin.brandPrimary : Color.Pin.white)
                .foregroundStyle(isSelected ? Color.Pin.white : Color.Pin.neutral600)
                .clipShape(Capsule())
                .overlay {
                    if !isSelected {
                        Capsule()
                            .strokeBorder(Color.Pin.neutral200, lineWidth: 1)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: PinSpacing.space2) {
        PinChip(title: "All", isSelected: true)
        PinChip(title: "Food", isSelected: false)
        PinChip(title: "Nature", isSelected: false)
    }
    .padding()
    .background(Color.Pin.neutral50)
}
