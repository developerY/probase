//
//  RoutePlanningView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import MapKit

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
            VStack(spacing: 16) {
                Text("Route Planning")
                    .font(.largeTitle.weight(.bold))
                    .padding(.top)

                // Preferences
                VStack(alignment: .leading) {
                    Toggle("Avoid Heavy Traffic", isOn: $avoidTraffic)
                    Toggle("Prefer Flat Terrain", isOn: $preferFlat)
                    Toggle("Prefer Scenic Routes", isOn: $preferScenic)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

                // Map with Flip Arrows Overlay
                ZStack {
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
                                    .foregroundColor(.blue)
                                    .padding(10)
                                    .background(Color.white.opacity(0.8))
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RoutePlanningView()
}
