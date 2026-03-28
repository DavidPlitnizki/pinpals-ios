import SwiftUI
import MapKit

struct MapScreen: View {
    @Environment(Router.self) private var router
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $position) {
                // Annotations will be added here
            }
            .mapStyle(.standard(elevation: .realistic))

            VStack(spacing: PinSpacing.space4) {
                HStack {
                    PinButton(title: "Create Meeting", icon: "plus", style: .primary) {
                        router.push(.createMeeting)
                    }
                    Spacer()
                }
                .padding(.horizontal, PinSpacing.space4)
            }
            .padding(.bottom, PinSpacing.space4)
        }
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.push(.profile)
                } label: {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.Pin.brandPrimary)
                }
            }
        }
    }
}
