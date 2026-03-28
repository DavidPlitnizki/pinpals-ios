import SwiftUI

enum PlaceCategory: String, CaseIterable, Codable, Identifiable {
    case food, nature, art, sports, coffee

    var id: String { rawValue }

    var displayName: String { rawValue.capitalized }

    var icon: String {
        switch self {
        case .food:    "fork.knife"
        case .nature:  "leaf.fill"
        case .art:     "paintpalette.fill"
        case .sports:  "figure.run"
        case .coffee:  "cup.and.saucer.fill"
        }
    }

    var color: Color {
        switch self {
        case .food:    Color.Pin.accentPrimary
        case .nature:  Color.Pin.brandPrimary
        case .art:     Color.Pin.info
        case .sports:  Color.Pin.warning
        case .coffee:  Color.Pin.accentPrimary
        }
    }
}
