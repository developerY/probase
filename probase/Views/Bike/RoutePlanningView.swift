//
//  RoutePlanningView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import MapKit

struct RoutePlanningView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var avoidTraffic = true
    @State private var preferFlat = false
    @State private var preferScenic = false
    @State private var arNavigationEnabled = false

    @State private var isPreferencesExpanded = true
    @State private var isPreferencesFlipped = false
    @State private var isMapFlipped = false

    @State private var isArSectionExpanded = true

    // Real-time stats (for back of preferences card)
    @State private var currentSpeed: Double = 14.5
    @State private var distanceTraveled: Double = 3.2
    @State private var currentElevation: Double = 120.0

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Title
                    Text("Route Planning")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)

                    // Preferences section with flip and expand/collapse
                    preferencesSection

                    // Map section with flip button overlay
                    mapSection

                    // AR Navigation section with a chevron for expansion
                    arNavigationSection

                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack {
            HStack {
                Text("Preferences")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                // Flip button for preferences
                Button(action: {
                    withAnimation(.spring()) {
                        isPreferencesFlipped.toggle()
                    }
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }

                // Chevron button for expand/collapse
                Button(action: {
                    withAnimation(.spring()) {
                        isPreferencesExpanded.toggle()
                    }
                }) {
                    Image(systemName: isPreferencesExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)

            if isPreferencesExpanded {
                if isPreferencesFlipped {
                    realTimeStatsCard
                } else {
                    preferencesOptionsCard
                }
            }
        }
    }

    private var preferencesOptionsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle(isOn: $avoidTraffic) {
                Label("Avoid Heavy Traffic", systemImage: "car.fill")
            }

            Toggle(isOn: $preferFlat) {
                Label("Prefer Flat Terrain", systemImage: "mountain.2")
            }

            Toggle(isOn: $preferScenic) {
                Label("Prefer Scenic Routes", systemImage: "leaf.fill")
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    private var realTimeStatsCard: some View {
        VStack(spacing: 12) {
            Text("Real-time Stats")
                .font(.headline)
                .foregroundColor(.white)

            Text("Distance Traveled: \(String(format: "%.1f", distanceTraveled)) km")
                .foregroundColor(.white.opacity(0.8))

            Text("Current Speed: \(String(format: "%.1f", currentSpeed)) km/h")
                .foregroundColor(.white.opacity(0.8))

            Text("Current Elevation: \(Int(currentElevation)) m")
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    // MARK: - Map Section
    private var mapSection: some View {
        ZStack {
            if isMapFlipped {
                VStack {
                    Text("Detailed Route Information")
                        .font(.headline)
                        .foregroundColor(.white)

                    Image(systemName: "bicycle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .foregroundColor(.white)

                    Text("Traffic, turns, and alternate routes")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .cornerRadius(15)
            } else {
                Map(
                    coordinateRegion: $region,
                    interactionModes: .all,
                    annotationItems: poiLocations
                ) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                print("\(location.name) tapped!")
                            }
                    }
                }
                .frame(height: isPreferencesExpanded ? 300 : 500)
                .cornerRadius(15)
                .padding(.horizontal)
            }

            // Flip button overlay for map
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            isMapFlipped.toggle()
                        }
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }

    // MARK: - AR Navigation Section
    private var arNavigationSection: some View {
        VStack {
            HStack {
                Text("AR Navigation (Beta)")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                Button {
                    withAnimation(.spring()) {
                        isArSectionExpanded.toggle()
                    }
                } label: {
                    Image(systemName: isArSectionExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)

            if isArSectionExpanded {
                Toggle("Enable AR Navigation", isOn: $arNavigationEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    .padding(.horizontal)

                Button {
                    // Start navigation
                } label: {
                    Text(arNavigationEnabled ? "Start AR Navigation" : "Start Navigation")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.bottom, 30)
            }
        }
    }
}

// MARK: - Point of Interest Model
struct POI: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let poiLocations = [
    POI(name: "Golden Gate Bridge", coordinate: CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)),
    POI(name: "Ferry Building", coordinate: CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937)),
    POI(name: "The Castro Theatre", coordinate: CLLocationCoordinate2D(latitude: 37.7621, longitude: -122.4348))
]

#Preview {
    RoutePlanningView()
}
