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
    @State private var isFlipped = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
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

                    // Preferences Section with Chevron
                    HStack {
                        Text("Preferences")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
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
                        VStack(alignment: .leading) {
                            Toggle("Avoid Heavy Traffic", isOn: $avoidTraffic)
                            Toggle("Prefer Flat Terrain", isOn: $preferFlat)
                            Toggle("Prefer Scenic Routes", isOn: $preferScenic)
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }

                    // Map View with flip button
                    ZStack {
                        if isFlipped {
                            // Back of the Map View with info
                            VStack {
                                Text("Detailed Route Information")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Image(systemName: "car.fill")
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
                            // Front map view
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

                        // Flip Button Overlay
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation(.spring()) {
                                        isFlipped.toggle()
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

                    // AR Navigation Toggle
                    Toggle("Enable AR Navigation (Beta)", isOn: $arNavigationEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                        .padding(.horizontal)

                    // Start Navigation Button
                    Button {
                        // Start route guidance (MapKit or a custom turn-by-turn)
                    } label: {
                        Text(arNavigationEnabled ? "Start AR Navigation" : "Start Navigation")
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .padding(.bottom, 30)

                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
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
