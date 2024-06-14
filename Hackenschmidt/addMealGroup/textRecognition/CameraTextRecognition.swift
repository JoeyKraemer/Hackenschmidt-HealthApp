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

            var nutritionInfo: [String: String] = ["Calories": "", "Fat": "", "Carbs": "", "Protein": ""]
            var textLines: [String] = []

            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                textLines.append(topCandidate.string)
            }

            // Log recognized text lines
            print("Recognized Text Lines: \(textLines)")

            var currentKey: String? = nil

            for (index, line) in textLines.enumerated() {
                if line.contains("Energie") || line.contains("kcal") || line.contains("Brennwert") || line.contains("energy") {
                    currentKey = "Calories"
                } else if line.contains("Fett") || line.contains("vetten") || line.contains("Fat") && !line.contains("davon gesättigte Fettsäuren") {
                    currentKey = "Fat"
                } else if line.contains("Kohlenhydrate") || line.contains("koolhydraten") || line.contains("carbohydrates") && !line.contains("davon Zucker") {
                    currentKey = "Carbs"
                } else if line.contains("Eiweiß") || line.contains("eiwitten") || line.contains("protein") {
                    currentKey = "Protein"
                }

                if let key = currentKey {
                    if nutritionInfo[key] == "" {
                        let value = extractValue(from: line)
                        if !value.isEmpty {
                            nutritionInfo[key] = value
                            currentKey = nil
                        }
                    }
                }
            }

            DispatchQueue.main.async {
                print("Nutrition Info: \(nutritionInfo)") // Print the dictionary to the console
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
        // Extract the first number found in the text followed by "kcal" or "g"
        let pattern = "(\\d+(?:[.,]\\d+)?)\\s*(kcal|g)?"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let range = NSRange(location: 0, length: text.utf16.count)
            if let match = regex.firstMatch(in: text, options: [], range: range) {
                let numberRange = Range(match.range(at: 1), in: text)
                let unitRange = Range(match.range(at: 2), in: text)
                if let number = numberRange.map({ String(text[$0]) }),
                   let unit = unitRange.map({ String(text[$0]) }) {
                    return "\(number) \(unit)"
                }
            }
        }
        return ""
    }
}
