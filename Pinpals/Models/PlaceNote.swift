import Foundation
import SwiftData

@Model
final class PlaceNote {
    var id: UUID
    var text: String
    var photoData: Data?
    var createdAt: Date

    var place: Place?

    init(text: String, photoData: Data? = nil) {
        self.id = UUID()
        self.text = text
        self.photoData = photoData
        self.createdAt = Date()
    }
}
