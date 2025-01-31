//
//  RoutePlanningView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import MapKit

// Custom POI struct conforming to Identifiable
struct POILocation: Identifiable {
    let id = UUID()  // Unique identifier
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct RoutePlanningView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var poiLocations = [
        POILocation(name: "Ferry Building", coordinate: CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937)),
        POILocation(name: "Golden Gate Park", coordinate: CLLocationCoordinate2D(latitude: 37.7694, longitude: -122.4862)),
        POILocation(name: "Chase Center", coordinate: CLLocationCoordinate2D(latitude: 37.768, longitude: -122.387))
    ]

    @State private var isFullscreenMap = false
    @State private var isFlipped = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Title with animation
                    Text("Route Planning")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.5))
                    //.animation(.easeIn(duration: 0.5), value: region)

                    // Preferences Section
                    VStack(alignment: .leading) {
                        Toggle("Avoid Heavy Traffic", isOn: .constant(true))
                        Toggle("Prefer Flat Terrain", isOn: .constant(false))
                        Toggle("Prefer Scenic Routes", isOn: .constant(false))
                    }
                    .padding()
                    .background(Color.white.opacity(0.2).cornerRadius(12))
                    .padding(.horizontal)

                    // Map and Flip/Fullscreen Controls
                    ZStack {
                        if isFullscreenMap {
                            // Fullscreen map view
                            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: poiLocations) { location in
                                MapAnnotation(coordinate: location.coordinate) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            print("\(location.name) tapped!")
                                        }
                                }
                            }
                            .ignoresSafeArea()
                        } else {
                            // Map in standard view with overlay
                            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: poiLocations) { location in
                                MapAnnotation(coordinate: location.coordinate) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            print("\(location.name) tapped!")
                                        }
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                    .padding(.horizontal)
                            )
                            .cornerRadius(15)
                        }

                        // Flip and Fullscreen Button Overlay
                        VStack {
                            HStack {
                                Spacer()

                                // Flip Button
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

                                // Fullscreen Button
                                Button {
                                    withAnimation(.spring()) {
                                        isFullscreenMap.toggle()
                                    }
                                } label: {
                                    Image(systemName: isFullscreenMap ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.green.opacity(0.8))
                                        .cornerRadius(8)
                                        .shadow(radius: 3)
                                }
                            }
                            .padding()
                            Spacer()
                        }
                    }
                    .frame(height: 300)
                    .padding(.horizontal)

                    // AR Navigation Toggle
                    Toggle("Enable AR Navigation (Beta)", isOn: .constant(false))
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                        .padding(.horizontal)

                    // Start Navigation Button
                    Button {
                        print("Start Navigation clicked")
                    } label: {
                        Text("Start Navigation")
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

#Preview {
    RoutePlanningView()
}
