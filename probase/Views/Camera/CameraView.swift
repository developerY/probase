//
//  CameraViewVM.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraVM = CameraViewModel()

    var body: some View {
        VStack {
            if let cgImage = cameraVM.capturedImage {
                Image(decorative: cgImage, scale: 1)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .overlay(Text("No photo yet").foregroundColor(.white))
                    .frame(height: 300)
            }
            
            Button("Capture Photo") {
                cameraVM.capturePhoto()
            }
            .padding()
        }
        .onAppear {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    print("User denied camera access")
                }
            }
        }
        .onDisappear {
            cameraVM.stopSession()
        }
    }
}
