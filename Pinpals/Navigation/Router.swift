import SwiftUI

@Observable
final class Router {
    var path = NavigationPath()

    func push(_ destination: Destination) {
        path.append(destination)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

enum Destination: Hashable {
    case placeDetail(UUID)
    case createMeeting
    case profile
    case editPlace(UUID)
}
