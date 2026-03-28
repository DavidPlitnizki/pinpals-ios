import SwiftUI

enum AppTab: Hashable {
    case map, explore, myPlaces, chat
}

struct AppTabView: View {
    @State private var selectedTab: AppTab = .map

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Map", systemImage: "map.fill", value: .map) {
                MapNavigationStack()
            }
            Tab("Explore", systemImage: "magnifyingglass", value: .explore) {
                ExploreNavigationStack()
            }
            Tab("My Places", systemImage: "bookmark.fill", value: .myPlaces) {
                MyPlacesNavigationStack()
            }
            Tab("Chat", systemImage: "bubble.left.and.bubble.right.fill", value: .chat) {
                ChatPlaceholderScreen()
            }
        }
        .tint(Color.Pin.brandPrimary)
    }
}

// MARK: - Navigation Stacks

struct MapNavigationStack: View {
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            MapScreen()
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(for: destination)
                }
        }
        .environment(router)
    }
}

struct ExploreNavigationStack: View {
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            ExploreScreen()
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(for: destination)
                }
        }
        .environment(router)
    }
}

struct MyPlacesNavigationStack: View {
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            MyPlacesScreen()
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(for: destination)
                }
        }
        .environment(router)
    }
}

// MARK: - Destination Resolver

@ViewBuilder
private func destinationView(for destination: Destination) -> some View {
    switch destination {
    case .placeDetail(let id):
        PlaceDetailScreen(placeId: id)
    case .createMeeting:
        CreateMeetingScreen()
    case .profile:
        ProfileScreen()
    case .editPlace(let id):
        PlaceDetailScreen(placeId: id)
    }
}
