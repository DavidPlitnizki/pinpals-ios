import SwiftUI
import SwiftData
import MapKit

struct CreateMeetingScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var descriptionText = ""
    @State private var meetingLocation: CLLocationCoordinate2D?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: PinSpacing.space5) {
                // Meeting Name
                VStack(alignment: .leading, spacing: PinSpacing.space1) {
                    Text("Meeting Name")
                        .font(.Pin.callout)
                        .foregroundStyle(Color.Pin.neutral900)
                    PinTextField(placeholder: "Weekend Hike", text: $name)
                }

                // Date & Time
                HStack(spacing: PinSpacing.space3) {
                    VStack(alignment: .leading, spacing: PinSpacing.space1) {
                        Text("Date")
                            .font(.Pin.callout)
                            .foregroundStyle(Color.Pin.neutral900)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    VStack(alignment: .leading, spacing: PinSpacing.space1) {
                        Text("Time")
                            .font(.Pin.callout)
                            .foregroundStyle(Color.Pin.neutral900)
                        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }

                // Location
                VStack(alignment: .leading, spacing: PinSpacing.space1) {
                    Text("Location")
                        .font(.Pin.callout)
                        .foregroundStyle(Color.Pin.neutral900)
                    Map(position: $cameraPosition) {
                        if let loc = meetingLocation {
                            Marker("Meeting", coordinate: loc)
                                .tint(Color.Pin.accentPrimary)
                        }
                    }
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
                }

                // Invite Friends (Phase 2 placeholder)
                VStack(alignment: .leading, spacing: PinSpacing.space2) {
                    Text("Invite Friends")
                        .font(.Pin.callout)
                        .foregroundStyle(Color.Pin.neutral900)
                    Text("Friend invitations coming soon")
                        .font(.Pin.caption)
                        .foregroundStyle(Color.Pin.neutral600)
                        .padding(PinSpacing.space4)
                        .frame(maxWidth: .infinity)
                        .background(Color.Pin.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: PinRadius.sm))
                }

                // Description
                VStack(alignment: .leading, spacing: PinSpacing.space1) {
                    Text("Description (optional)")
                        .font(.Pin.callout)
                        .foregroundStyle(Color.Pin.neutral900)
                    PinTextField(placeholder: "Let's explore the mountain trail together!", text: $descriptionText)
                }

                // Create button
                PinButton(title: "Create Meeting", icon: "plus", style: .primary, isFullWidth: true) {
                    createMeeting()
                }
            }
            .padding(PinSpacing.space4)
        }
        .background(Color.Pin.white)
        .navigationTitle("Create Meeting")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.Pin.neutral900)
                }
            }
        }
    }

    private func createMeeting() {
        let meeting = Meeting(
            name: name,
            descriptionText: descriptionText,
            date: combinedDateTime,
            latitude: meetingLocation?.latitude ?? 0,
            longitude: meetingLocation?.longitude ?? 0
        )
        modelContext.insert(meeting)
        dismiss()
    }

    private var combinedDateTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        var combined = DateComponents()
        combined.year = dateComponents.year
        combined.month = dateComponents.month
        combined.day = dateComponents.day
        combined.hour = timeComponents.hour
        combined.minute = timeComponents.minute
        return calendar.date(from: combined) ?? date
    }
}

#Preview {
    NavigationStack {
        CreateMeetingScreen()
    }
    .modelContainer(for: [Meeting.self], inMemory: true)
}
