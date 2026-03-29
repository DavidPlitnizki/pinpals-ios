import SwiftUI
import MapKit

struct MapScreen: View {
    @Environment(Router.self) private var router
    @Environment(LocationService.self) private var locationService

    @State private var position: MapCameraPosition = .automatic
    @State private var tappedCoordinate: CLLocationCoordinate2D?
    @State private var zoomLevel: Double = 0.05
    @State private var cameraCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    func handleMapTap(coordinate: CLLocationCoordinate2D) {
        print("tapped pos: \(coordinate.latitude), \(coordinate.longitude)")
        tappedCoordinate = coordinate
        cameraCenter = coordinate
        withAnimation(.smooth(duration: 0.4)) {
            position = .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
            ))
        }
    }

    func zoomIn() {
        zoomLevel = max(zoomLevel / 2, 0.002)
        moveCamera(to: cameraCenter, zoom: zoomLevel)
    }

    func zoomOut() {
        zoomLevel = min(zoomLevel * 2, 90)
        moveCamera(to: cameraCenter, zoom: zoomLevel)
    }

    func centerOnLocation() {
        if locationService.authorizationStatus == .notDetermined {
            locationService.requestPermission()
            return
        }
        guard let coord = locationService.currentLocation else { return }
        cameraCenter = coord
        withAnimation(.smooth(duration: 0.5)) {
            position = .region(MKCoordinateRegion(
                center: coord,
                span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
            ))
        }
    }

    private func moveCamera(to center: CLLocationCoordinate2D, zoom: Double) {
        withAnimation(.smooth(duration: 0.35)) {
            position = .region(MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
            ))
        }
    }

    var body: some View {
        MapReader { proxy in
            Map(position: $position) {
                if let coord = tappedCoordinate {
                    Marker("Pin", coordinate: coord)
                        .tint(Color.Pin.accentPrimary)
                }
                UserAnnotation()
            }
            .mapStyle(.standard(elevation: .realistic))
            .onTapGesture { screenPoint in
                if let coord = proxy.convert(screenPoint, from: .local) {
                    handleMapTap(coordinate: coord)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                // Правая панель: зум + локация + FAB
                VStack(spacing: PinSpacing.space2) {
                    // Зум +/-
                    VStack(spacing: 0) {
                        mapControlButton(icon: "plus", action: zoomIn)
                        Divider().padding(.horizontal, 8)
                        mapControlButton(icon: "minus", action: zoomOut)
                    }
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
                    .shadow(color: .black.opacity(0.15), radius: 8, y: 3)

                    // Центр по GPS
                    mapControlButton(icon: "location.fill", action: centerOnLocation)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 3)

                    // FAB — Create Meeting
                    Button {
                        router.push(.createMeeting)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.Pin.brandPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: PinRadius.md))
                            .shadow(color: Color.Pin.brandPrimary.opacity(0.4), radius: 10, y: 4)
                            .overlay {
                                RoundedRectangle(cornerRadius: PinRadius.md)
                                    .strokeBorder(.white.opacity(0.25), lineWidth: 1)
                            }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.trailing, PinSpacing.space4)
                .padding(.bottom, PinSpacing.space8)
            }
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
                        .shadow(color: .white.opacity(0.8), radius: 4)
                }
            }
        }
        .onAppear {
            locationService.requestPermission()
        }
        .onChange(of: locationService.currentLocation?.latitude) { _, _ in
            // При первом получении локации — центрируем карту
            if let coord = locationService.currentLocation, cameraCenter.latitude == 0 {
                cameraCenter = coord
                withAnimation(.smooth(duration: 0.6)) {
                    position = .region(MKCoordinateRegion(
                        center: coord,
                        span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
                    ))
                }
            }
        }
    }

    @ViewBuilder
    private func mapControlButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Pin.neutral900)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MapScreen()
        .environment(Router())
        .environment(LocationService())
}
