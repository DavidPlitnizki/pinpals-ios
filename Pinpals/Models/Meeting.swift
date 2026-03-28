import Foundation
import SwiftData
import CoreLocation

@Model
final class Meeting {
    var id: UUID
    var name: String
    var descriptionText: String
    var date: Date
    var latitude: Double
    var longitude: Double
    var createdAt: Date
    // Phase 2: @Relationship var invitedFriends: [Friend]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(
        name: String,
        descriptionText: String = "",
        date: Date,
        latitude: Double,
        longitude: Double
    ) {
        self.id = UUID()
        self.name = name
        self.descriptionText = descriptionText
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = Date()
    }
}
