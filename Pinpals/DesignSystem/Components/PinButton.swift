import SwiftUI

struct PinButton: View {
    let title: String
    var icon: String?
    var style: Style = .primary
    var isFullWidth: Bool = false
    let action: () -> Void

    enum Style {
        case primary, secondary, outline
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: PinSpacing.space2) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                }
                Text(title)
                    .font(.Pin.callout)
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding(.horizontal, PinSpacing.space5)
            .padding(.vertical, PinSpacing.space3)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
            .overlay {
                if style == .outline {
                    RoundedRectangle(cornerRadius: PinRadius.md)
                        .strokeBorder(Color.Pin.brandPrimary, lineWidth: 1.5)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: Color.Pin.brandPrimary
        case .secondary: Color.Pin.brandLight
        case .outline: .clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: Color.Pin.white
        case .secondary: Color.Pin.brandDark
        case .outline: Color.Pin.brandPrimary
        }
    }
}
