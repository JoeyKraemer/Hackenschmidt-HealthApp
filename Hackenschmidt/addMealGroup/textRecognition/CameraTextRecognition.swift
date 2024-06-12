//
//  CameraTextRecognition.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 12.06.24.
//

import UIKit
import Vision

class CameraTextRecognition {
    static func recognizeText(in image: UIImage, completion: @escaping ([String: String]) -> Void) {
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            var nutritionInfo: [String: String] = [:]

            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                let recognizedText = topCandidate.string

                if recognizedText.contains("Protein") {
                    nutritionInfo["Protein"] = extractValue(from: recognizedText)
                } else if recognizedText.contains("Calories") {
                    nutritionInfo["Calories"] = extractValue(from: recognizedText)
                } else if recognizedText.contains("Fat") {
                    nutritionInfo["Fat"] = extractValue(from: recognizedText)
                } else if recognizedText.contains("Carbs") {
                    nutritionInfo["Carbs"] = extractValue(from: recognizedText)
                }
            }

            DispatchQueue.main.async {
                completion(nutritionInfo)
            }
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }

    static func extractValue(from text: String) -> String {
        // Implement your logic to extract the numerical value from the text
        // For simplicity, this example just returns the full text
        text
    }
}
