//
//  Screens.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI

struct HeartMonitorScreensGridPreview: View {
    // An array of tuples that includes a title and the corresponding view wrapped in AnyView.
    let screens: [(title: String, view: AnyView)] = [
        ("Dashboard", AnyView(HeartDashboardView())),
        ("History", AnyView(HeartHistoryView())),
        ("Log Event", AnyView(HeartLogEventView())),
        ("Workout", AnyView(WorkoutActivityView())),
        ("Alerts", AnyView(HeartAlertsView())),
        ("Settings", AnyView(HeartSettingsView())),
        ("Reports", AnyView(ReportsSharingView()))
    ]
    
    // Define a two-column grid.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<screens.count, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        // Display the screen title.
                        Text(screens[index].title)
                            .font(.headline)
                            .padding(.horizontal, 8)
                            .padding(.top, 8)
                        
                        // Display the view preview. Adjust the frame height as needed.
                        screens[index].view
                            .frame(height: 300)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

struct HeartMonitorScreensGridPreview_Previews: PreviewProvider {
    static var previews: some View {
        HeartMonitorScreensGridPreview()
            .previewDevice("iPhone 14 Pro")
    }
}
