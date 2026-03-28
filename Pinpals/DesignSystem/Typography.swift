import SwiftUI

extension Font {
    enum Pin {
        static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title      = Font.system(size: 22, weight: .semibold, design: .rounded)
        static let headline   = Font.system(size: 17, weight: .semibold, design: .rounded)
        static let body       = Font.system(size: 15, weight: .regular)
        static let callout    = Font.system(size: 14, weight: .medium)
        static let caption    = Font.system(size: 12, weight: .regular)
    }
}
