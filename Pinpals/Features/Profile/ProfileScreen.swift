import SwiftUI
import SwiftData

struct ProfileScreen: View {
    @Query private var places: [Place]

    var body: some View {
        ScrollView {
            VStack(spacing: PinSpacing.space6) {
                // Avatar
                Circle()
                    .fill(Color.Pin.brandPrimary)
                    .frame(width: 100, height: 100)
                    .overlay {
                        Text("AJ")
                            .font(.Pin.largeTitle)
                            .foregroundStyle(Color.Pin.white)
                    }

                // Name & bio
                VStack(spacing: PinSpacing.space1) {
                    Text("Alex Johnson")
                        .font(.Pin.title)
                        .foregroundStyle(Color.Pin.neutral900)
                    Text("Explorer & coffee enthusiast")
                        .font(.Pin.caption)
                        .foregroundStyle(Color.Pin.neutral600)
                }

                // Stats
                HStack(spacing: PinSpacing.space8) {
                    statItem(value: "\(places.count)", label: "Places")
                    statItem(value: "0", label: "Cities")
                    statItem(value: "0", label: "Countries")
                }
                .padding(PinSpacing.space5)
                .background(Color.Pin.neutral50)
                .clipShape(RoundedRectangle(cornerRadius: PinRadius.lg))

                // Achievements placeholder
                VStack(alignment: .leading, spacing: PinSpacing.space3) {
                    Text("Achievements")
                        .font(.Pin.headline)
                        .foregroundStyle(Color.Pin.neutral900)

                    HStack(spacing: PinSpacing.space4) {
                        achievementBadge(icon: "mappin.circle.fill", title: "First Pin")
                        achievementBadge(icon: "flame.fill", title: "10 Streak")
                        achievementBadge(icon: "globe.americas.fill", title: "Explorer")
                        achievementBadge(icon: "star.fill", title: "Reviewer")
                    }
                }

                // Friends placeholder
                VStack(alignment: .leading, spacing: PinSpacing.space3) {
                    HStack {
                        Text("Friends")
                            .font(.Pin.headline)
                            .foregroundStyle(Color.Pin.neutral900)
                        Spacer()
                        Text("Coming soon")
                            .font(.Pin.caption)
                            .foregroundStyle(Color.Pin.neutral600)
                    }
                }
            }
            .padding(PinSpacing.space4)
        }
        .background(Color.Pin.neutral50)
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Settings
                } label: {
                    Image(systemName: "gearshape")
                        .foregroundStyle(Color.Pin.neutral600)
                }
            }
        }
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: PinSpacing.space1) {
            Text(value)
                .font(.Pin.title)
                .foregroundStyle(Color.Pin.neutral900)
            Text(label)
                .font(.Pin.caption)
                .foregroundStyle(Color.Pin.neutral600)
        }
    }

    private func achievementBadge(icon: String, title: String) -> some View {
        VStack(spacing: PinSpacing.space2) {
            Circle()
                .fill(Color.Pin.neutral50)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(Color.Pin.neutral200)
                }
            Text(title)
                .font(.Pin.caption)
                .foregroundStyle(Color.Pin.neutral600)
        }
    }
}
