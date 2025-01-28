//
//  BikeView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import MapKit
import Charts

struct BikeViewUI: View {
    // MARK: - State Properties
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var currentSpeed: Double = 18.0
    @State private var heartRate: Int = 130
    @State private var distanceTraveled: Double = 25.4
    @State private var distanceGoal: Double = 50.0
    @State private var elevationGain: Int = 420
    
    @State private var speedData: [SpeedEntry] = (0..<15).map {
        SpeedEntry(time: Double($0), speed: Double.random(in: 10...30))
    }
    
    var body: some View {
        ZStack {
            // MARK: - Background
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                center: .center,
                startRadius: 10,
                endRadius: UIScreen.main.bounds.width
            )
            .ignoresSafeArea()
            
            // MARK: - Main ScrollView
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // MARK: - Header: Progress Ring + Speed
                    VStack(spacing: 16) {
                        Text("Bike Tracker")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        ZStack {
                            // Outer Circle
                            Circle()
                                .stroke(
                                    Color.white.opacity(0.3),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                )
                                .frame(width: 200, height: 200)
                            
                            // Progress Circle
                            Circle()
                                .trim(from: 0, to: progressRatio)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.yellow]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                )
                                .frame(width: 200, height: 200)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: progressRatio)
                            
                            // Current Speed
                            VStack {
                                Text("\(Int(currentSpeed))")
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Text("km/h")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        
                        // Goal vs Actual
                        Text("Goal: \(String(format: "%.0f", distanceGoal)) km")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                    }
                    
                    // MARK: - Floating Stats Cards
                    HStack(spacing: 16) {
                        StatBubbleView(iconName: "heart.fill",
                                       title: "Heart Rate",
                                       value: "\(heartRate) bpm",
                                       color: .pink)
                        
                        StatBubbleView(iconName: "map.fill",
                                       title: "Distance",
                                       value: "\(String(format: "%.1f", distanceTraveled)) km",
                                       color: .orange)
                        
                        StatBubbleView(iconName: "arrow.up.forward.circle.fill",
                                       title: "Elevation",
                                       value: "\(elevationGain) m",
                                       color: .yellow)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Speed Chart
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Speed History")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.bottom, 4)
                        
                        Chart {
                            ForEach(speedData) { entry in
                                LineMark(
                                    x: .value("Time", entry.time),
                                    y: .value("Speed", entry.speed)
                                )
                                .foregroundStyle(.white)
                            }
                        }
                        .frame(height: 200)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 80)
                }
                .padding(.bottom, 100) // Extra space for bottom card
            }
            
            // MARK: - Bottom Map Card
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 200)
                        .shadow(radius: 5)
                    
                    /*Map(coordinateRegion: $region)
                        .cornerRadius(20)
                        .padding()*/
                    
                    /*Map(coordinateRegion: $region)
                                        .frame(height: 300) // The map is now confined to 300px in height
                                        .cornerRadius(15)
                                        .padding()*/
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
    }
    
    // MARK: - Progress Ratio Computation
    private var progressRatio: CGFloat {
        let ratio = distanceTraveled / distanceGoal
        return min(max(CGFloat(ratio), 0), 1)
    }
}

// MARK: - StatBubbleView
struct StatBubbleView: View {
    let iconName: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.title2)
            Text(title)
                .font(.footnote)
            Text(value)
                .font(.headline.bold())
        }
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            Circle()
                .fill(color.opacity(0.2))
        )
        .clipShape(Rectangle()) // or any shape to cut it off
        .cornerRadius(12)
    }
}

// MARK: - Speed Data Model
struct SpeedEntry: Identifiable {
    let id = UUID()
    let time: Double
    let speed: Double
}


// MARK: - Preview
#Preview {
    BikeViewUI()
}

