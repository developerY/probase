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
    @State private var isFlipped = false
    @State private var isFullscreenMap = false
    @State private var showRoutePath = false

    // Mock Points of Interest
    let poiLocations = [
        ("Ferry Building", CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937)),
        ("Golden Gate Park", CLLocationCoordinate2D(latitude: 37.7694, longitude: -122.4862)),
        ("Chase Center", CLLocationCoordinate2D(latitude: 37.768, longitude: -122.387))
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("Route Planning")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.5), value: region)

                    // Preferences with animation on appearance
                    VStack(alignment: .leading) {
                        Toggle("Avoid Heavy Traffic", isOn: $avoidTraffic)
                        Toggle("Prefer Flat Terrain", isOn: $preferFlat)
                        Toggle("Prefer Scenic Routes", isOn: $preferScenic)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .transition(.scale)
                    .animation(.spring(), value: region)

                    // Map with flip, fullscreen, and route drawing
                    ZStack {
                        if isFullscreenMap {
                            // Fullscreen Map
                            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: poiLocations) { location in
                                MapAnnotation(coordinate: location.1) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            print("\(location.0) tapped!")
                                        }
                                }
                            }
                            .ignoresSafeArea()
                        } else {
                            // Map with POIs and route animation
                            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: poiLocations) { location in
                                MapAnnotation(coordinate: location.1) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            print("\(location.0) tapped!")
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

                    // AR Toggle
                    Toggle("Enable AR Navigation (Beta)", isOn: $arNavigationEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                        .padding(.horizontal)

                    // Start Navigation Button
                    Button {
                        showRoutePath.toggle()
                        print("Start Navigation Pressed")
                    } label: {
                        Text(arNavigationEnabled ? "Start AR Navigation" : "Start Navigation")
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .padding(.bottom, 30)

                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RoutePlanningView()
}

