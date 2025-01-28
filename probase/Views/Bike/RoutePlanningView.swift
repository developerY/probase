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
                
                // Map Preview
                Map(coordinateRegion: $region)
                    .frame(height: 300)
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                // AR Toggle
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

#Preview
{
   RoutePlanningView()
}

