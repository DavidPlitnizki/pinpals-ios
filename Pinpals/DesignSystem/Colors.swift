import SwiftUI

extension Color {
    enum Pin {
        // Brand
        static let brandPrimary = Color(hex: 0x4A7C59)
        static let brandDark    = Color(hex: 0x2C5C3F)
        static let brandLight   = Color(hex: 0xD6EDE1)

        // Accent
        static let accentPrimary = Color(hex: 0xE8834A)
        static let accentLight   = Color(hex: 0xFDEBD0)

        // Neutral
        static let neutral50  = Color(hex: 0xF0F5F2)
        static let neutral200 = Color(hex: 0xC8DAD0)
        static let neutral600 = Color(hex: 0x6B7F72)
        static let neutral900 = Color(hex: 0x1C2B22)

        // Semantic
        static let error   = Color(hex: 0xD94F4F)
        static let success = Color(hex: 0x3A9E6A)
        static let warning = Color(hex: 0xE8B84A)
        static let info    = Color(hex: 0x4A8EC2)

        // Base
        static let white = Color(hex: 0xFFFFFF)
    }
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
