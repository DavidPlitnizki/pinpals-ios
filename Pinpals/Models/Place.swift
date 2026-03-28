import Foundation
import SwiftData
import CoreLocation

@Model
final class Place {
    var id: UUID
    var name: String
    var descriptionText: String
    var address: String
    var latitude: Double
    var longitude: Double
    var categoryRaw: String
    var rating: Int
    var statusRaw: String
    var heroImageData: Data?
    var hours: String?
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \PlaceNote.place)
    var notes: [PlaceNote]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var category: PlaceCategory {
        get { PlaceCategory(rawValue: categoryRaw) ?? .food }
        set { categoryRaw = newValue.rawValue }
    }

    var status: PlaceStatus {
        get { PlaceStatus(rawValue: statusRaw) ?? .wantToVisit }
        set { statusRaw = newValue.rawValue }
    }

    init(
        name: String,
        descriptionText: String = "",
        address: String = "",
        latitude: Double,
        longitude: Double,
        category: PlaceCategory,
        rating: Int = 0,
        status: PlaceStatus = .wantToVisit,
        heroImageData: Data? = nil,
        hours: String? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.descriptionText = descriptionText
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.categoryRaw = category.rawValue
        self.rating = rating
        self.statusRaw = status.rawValue
        self.heroImageData = heroImageData
        self.hours = hours
        self.createdAt = Date()
        self.updatedAt = Date()
        self.notes = []
    }
}

enum PlaceStatus: String, CaseIterable, Codable {
    case visited
    case wantToVisit

    var displayName: String {
        switch self {
        case .visited: "Visited"
        case .wantToVisit: "Want to Visit"
        }
    }
}
