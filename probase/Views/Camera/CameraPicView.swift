//
//  CameraView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import UIKit

struct CameraPicView: UIViewControllerRepresentable {
    /// A binding to store the captured image in SwiftUI
    @Binding var capturedImage: UIImage?
    
    /// A binding to control whether the camera (image picker) is presented
    @Binding var isPresented: Bool
    
    /// Make the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // Configure for camera usage
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        
        return picker
    }
    
    /// No need to update the view controller after creation
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    /// Create a Coordinator which acts as the delegate for the picker
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: CameraPicView
        
        init(_ parent: CameraPicView) {
            self.parent = parent
        }
        
        // Called when a photo is taken or selected
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            // Retrieve the picked image
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image
            }
            parent.isPresented = false
        }
        
        // Called when the user cancels the picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

