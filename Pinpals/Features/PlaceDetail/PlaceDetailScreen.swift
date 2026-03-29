import SwiftUI
import SwiftData

struct PlaceDetailScreen: View {
    let placeId: UUID
    @Environment(\.modelContext) private var modelContext
    @Query private var places: [Place]

    private var place: Place? {
        places.first { $0.id == placeId }
    }

    var body: some View {
        Group {
            if let place {
                placeContent(place)
            } else {
                ContentUnavailableView("Place Not Found", systemImage: "mappin.slash")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func placeContent(_ place: Place) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: PinSpacing.space4) {
                // Hero image placeholder
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.Pin.brandLight)
                    .frame(height: 240)
                    .overlay {
                        if let data = place.heroImageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: place.category.icon)
                                .font(.system(size: 48))
                                .foregroundStyle(Color.Pin.brandPrimary)
                        }
                    }
                    .clipped()

                VStack(alignment: .leading, spacing: PinSpacing.space3) {
                    // Category + status
                    HStack(spacing: PinSpacing.space2) {
                        PinChip(title: place.category.displayName, isSelected: false)
                        if place.status == .visited {
                            PinChip(title: "Visited", isSelected: true)
                        }
                    }

                    // Name
                    Text(place.name)
                        .font(.Pin.title)
                        .foregroundStyle(Color.Pin.neutral900)

                    // Address
                    if !place.address.isEmpty {
                        Label(place.address, systemImage: "location.fill")
                            .font(.Pin.caption)
                            .foregroundStyle(Color.Pin.neutral600)
                    }

                    // Hours
                    if let hours = place.hours {
                        Label(hours, systemImage: "clock.fill")
                            .font(.Pin.caption)
                            .foregroundStyle(Color.Pin.neutral600)
                    }

                    // Description
                    if !place.descriptionText.isEmpty {
                        Text(place.descriptionText)
                            .font(.Pin.body)
                            .foregroundStyle(Color.Pin.neutral600)
                    }

                    // Action buttons
                    HStack(spacing: PinSpacing.space3) {
                        PinButton(title: "Route", icon: "arrow.triangle.turn.up.right.diamond.fill", style: .primary) {}
                        PinButton(title: "Save", icon: "bookmark", style: .outline) {}
                        PinButton(title: "Visited", icon: "checkmark.circle", style: .outline) {}
                    }

                    // Rating
                    PinRatingView(rating: place.rating)

                    // Notes section
                    Divider()

                    HStack {
                        Text("My Notes")
                            .font(.Pin.headline)
                            .foregroundStyle(Color.Pin.neutral900)
                        Spacer()
                        Button {
                            // Edit notes
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundStyle(Color.Pin.brandPrimary)
                        }
                    }

                    if place.notes.isEmpty {
                        Text("No notes yet. Tap the pencil to add one.")
                            .font(.Pin.caption)
                            .foregroundStyle(Color.Pin.neutral600)
                    } else {
                        ForEach(place.notes.sorted(by: { $0.createdAt > $1.createdAt })) { note in
                            noteRow(note)
                        }
                    }
                }
                .padding(.horizontal, PinSpacing.space4)
            }
        }
    }

    @ViewBuilder
    private func noteRow(_ note: PlaceNote) -> some View {
        VStack(alignment: .leading, spacing: PinSpacing.space1) {
            Text(note.createdAt, style: .date)
                .font(.Pin.caption)
                .foregroundStyle(Color.Pin.accentPrimary)
            Text(note.text)
                .font(.Pin.body)
                .foregroundStyle(Color.Pin.neutral900)
        }
        .padding(PinSpacing.space3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.Pin.accentLight)
        .clipShape(RoundedRectangle(cornerRadius: PinRadius.sm))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Place.self, PlaceNote.self, configurations: config)
    let place = Place(
        name: "Botanical Gardens",
        descriptionText: "A serene botanical paradise featuring exotic plants and peaceful water features.",
        address: "123 Garden Ave, Green District",
        latitude: 55.75,
        longitude: 37.61,
        category: .nature,
        rating: 4,
        status: .visited,
        hours: "Mon-Sun, 8:00 AM – 8:00 PM"
    )
    let note = PlaceNote(text: "The orchid section was breathtaking! Must come back during the tulip season in April.")
    place.notes.append(note)
    container.mainContext.insert(place)
    return NavigationStack {
        PlaceDetailScreen(placeId: place.id)
    }
    .modelContainer(container)
}
