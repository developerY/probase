//
//  CameraView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import AVFoundation

struct CameraViewUI: View {
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .padding()
                } else {
                    Text("No image captured yet")
                        .foregroundColor(.secondary)
                }
                
                Button(action: {
                    isShowingCamera = true
                }) {
                    Text("Open Camera")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("SwiftUI Camera Example")
            .sheet(isPresented: $isShowingCamera) {
                // Present our CameraView
                CameraPicView(capturedImage: $capturedImage, isPresented: $isShowingCamera)
            }
        }
    }
}

