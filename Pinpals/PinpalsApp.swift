import SwiftUI
import SwiftData

@main
struct PinpalsApp: App {
    let container: ModelContainer
    @State private var locationService = LocationService()

    init() {
        let schema = Schema([
            Place.self,
            PlaceNote.self,
            Meeting.self,
            UserProfile.self,
        ])
        do {
            container = try ModelContainer(for: schema)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(locationService)
        }
        .modelContainer(container)
    }
}
