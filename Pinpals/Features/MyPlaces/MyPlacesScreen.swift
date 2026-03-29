import SwiftUI

struct MyPlacesScreen: View {
    @Environment(Router.self) private var router
    @State private var selectedFilter: PlaceStatus?
    @State private var isGridView = true

    var body: some View {
        VStack(spacing: 0) {
            // View toggle + filters
            HStack {
                // Filter chips
                HStack(spacing: PinSpacing.space2) {
                    PinChip(title: "All", isSelected: selectedFilter == nil) {
                        selectedFilter = nil
                    }
                    ForEach(PlaceStatus.allCases, id: \.rawValue) { status in
                        PinChip(title: status.displayName, isSelected: selectedFilter == status) {
                            selectedFilter = status
                        }
                    }
                }

                Spacer()

                // Grid/List toggle
                HStack(spacing: PinSpacing.space1) {
                    Button { isGridView = true } label: {
                        Image(systemName: "square.grid.2x2")
                            .foregroundStyle(isGridView ? Color.Pin.brandPrimary : Color.Pin.neutral600)
                    }
                    Button { isGridView = false } label: {
                        Image(systemName: "list.bullet")
                            .foregroundStyle(!isGridView ? Color.Pin.brandPrimary : Color.Pin.neutral600)
                    }
                }
                .padding(PinSpacing.space1)
                .background(Color.Pin.neutral50)
                .clipShape(RoundedRectangle(cornerRadius: PinRadius.sm))
            }
            .padding(.horizontal, PinSpacing.space4)
            .padding(.vertical, PinSpacing.space3)

            // Content
            ScrollView {
                ContentUnavailableView("No Saved Places", systemImage: "bookmark.slash", description: Text("Tap + to add your first place"))
            }
        }
        .background(Color.Pin.neutral50)
        .navigationTitle("My Places")
        .overlay(alignment: .bottomTrailing) {
            Button {
                // Add new place
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.Pin.white)
                    .frame(width: 56, height: 56)
                    .background(Color.Pin.accentPrimary)
                    .clipShape(Circle())
                    .shadow(color: Color.Pin.accentPrimary.opacity(0.3), radius: 8, y: 4)
            }
            .padding(PinSpacing.space6)
        }
    }
}

#Preview {
    NavigationStack {
        MyPlacesScreen()
    }
    .environment(Router())
}
