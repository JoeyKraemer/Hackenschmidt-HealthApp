//
//  CameraTextRecognitionView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 12.06.24.
//

import SwiftUI
import UIKit

struct CameraTextRecognitionView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraTextRecognitionView

        init(parent: CameraTextRecognitionView) {
            self.parent = parent
        }

        func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                parent.image = pickedImage
                CameraTextRecognition.recognizeText(in: pickedImage) { nutritionInfo in
                    self.parent.nutritionInfo = nutritionInfo
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Binding var image: UIImage?
    @Binding var nutritionInfo: [String: String]
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) {}
}
