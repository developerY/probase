//
//  GlobalNavigationView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI

struct GlobalNavigationView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // 1st Button -> Screen One
                    NavigationLink(destination: NotesListView()) {
                        Text("Notes Example")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }

                    // 2nd Button -> Screen Two
                    NavigationLink(destination: CameraViewUI()) {
                        Text("Camera Example")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    
                    // 3rd Button -> Screen Three
                    NavigationLink(destination: ExampleContentView()) {
                        Text("Go to Screen Three")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Menu")
        }
    }
}

struct ScreenTwoView: View {
    var body: some View {
        Text("Screen Two")
            .font(.largeTitle)
            .navigationTitle("Screen Two")
    }
}
