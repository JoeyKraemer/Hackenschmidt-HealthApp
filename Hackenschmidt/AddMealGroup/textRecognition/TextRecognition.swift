//  TextRecognition.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 12.06.24.
//

import UIKit
import Vision

class textRecognition: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .camera // You can change this to .camera if you want to capture images using the camera
    }

    @IBAction func selectImageTapped(_: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            recognizeText(image: pickedImage)
        }

        dismiss(animated: true, completion: nil)
    }

    func recognizeText(image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest(completionHandler: { request, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }

            let nutritionInfo: [String: String] = [:]

            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                let recognizedText = topCandidate.string

                if recognizedText.contains("Protein") {
                } else if recognizedText.contains("Calories") {
                } else if recognizedText.contains("Fat") {
                } else if recognizedText.contains("Carbs") {}
            }

            print("Nutrition Information: \(nutritionInfo)")
        })

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }
}
