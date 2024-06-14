//
//  FoodFormCameraView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 12.06.24.
//
import SwiftUI

struct FoodFormCameraView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var nutritionInfo: [String: String] = [:]

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("Select an Image")
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 300)
                    .background(Color.black.opacity(0.1))
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Take Photo")
            }
            .sheet(isPresented: $isImagePickerPresented) {
                CameraTextRecognitionView(image: $selectedImage, nutritionInfo: $nutritionInfo)
            }

            if !nutritionInfo.isEmpty {
                ForEach(nutritionInfo.keys.sorted(), id: \.self) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        Text(nutritionInfo[key] ?? "")
                    }
                    .padding()
                }
            }
        }
    }
}

struct FoodFormCameraView_Previews: PreviewProvider {
    static var previews: some View {
        FoodFormCameraView()
    }
}
