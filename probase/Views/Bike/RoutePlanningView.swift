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

                    // Preferences
                    VStack(alignment: .leading) {
                        Toggle("Avoid Heavy Traffic", isOn: $avoidTraffic)
                        Toggle("Prefer Flat Terrain", isOn: $preferFlat)
                        Toggle("Prefer Scenic Routes", isOn: $preferScenic)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Map with Flip Arrows Overlay
                    ZStack {
                        // Map or alternative content
                        if !isFlipped {
                            Map(coordinateRegion: $region, interactionModes: .all)
                                .cornerRadius(15)
                        } else {
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
                        }

                        // Overlay tint for a polished look
                        Color.black.opacity(0.05)
                            .cornerRadius(15)
                            .allowsHitTesting(false)  // Allow touch events to pass through to the map

                        // Flip Arrows Overlay
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
                                .padding()
                            }
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
                        // Start route guidance (MapKit or custom turn-by-turn)
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

