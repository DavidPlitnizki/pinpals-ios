import Foundation
import SwiftData

@Model
final class UserProfile {
    var id: UUID
    var name: String
    var bio: String
    var avatarData: Data?
    var joinedDate: Date

    init(name: String, bio: String = "", avatarData: Data? = nil) {
        self.id = UUID()
        self.name = name
        self.bio = bio
        self.avatarData = avatarData
        self.joinedDate = Date()
    }
}
