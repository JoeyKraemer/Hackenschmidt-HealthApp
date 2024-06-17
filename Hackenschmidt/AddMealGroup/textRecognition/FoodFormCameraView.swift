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
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                CameraTextRecognitionView(image: $selectedImage, nutritionInfo: $nutritionInfo)
            }

            if !nutritionInfo.isEmpty {
                Form {
                    Section(header: Text("What is the product name?")) {
                        TextField("Name", text: Binding(
                            get: { nutritionInfo["Name"] ?? "" },
                            set: { nutritionInfo["Name"] = $0 }
                        ))
                    }

                    Section(header: Text("What is the product weight?")) {
                        TextField("Weight", text: Binding(
                            get: { nutritionInfo["Weight"] ?? "" },
                            set: { nutritionInfo["Weight"] = $0 }
                        ))
                    }

                    Section(header: Text("Nutrition per 100g")) {
                        HStack {
                            Text("Carbs")
                            Spacer()
                            TextField("Carbs", text: Binding(
                                get: { nutritionInfo["Carbs"] ?? "Not Available" },
                                set: { nutritionInfo["Carbs"] = $0 }
                            ))
                        }
                        HStack {
                            Text("Fat")
                            Spacer()
                            TextField("Fat", text: Binding(
                                get: { nutritionInfo["Fat"] ?? "Not Available" },
                                set: { nutritionInfo["Fat"] = $0 }
                            ))
                        }
                        HStack {
                            Text("Protein")
                            Spacer()
                            TextField("Protein", text: Binding(
                                get: { nutritionInfo["Protein"] ?? "Not Available" },
                                set: { nutritionInfo["Protein"] = $0 }
                            ))
                        }
                    }

                    Section(header: Text("Calorie on 100g")) {
                        TextField("Calories", text: Binding(
                            get: { nutritionInfo["Calories"] ?? "" },
                            set: { nutritionInfo["Calories"] = $0 }
                        ))
                    }

                    Button(action: {
                        // Add functionality
                    }) {
                        Text("ADD")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

struct FoodFormCameraView_Previews: PreviewProvider {
    static var previews: some View {
        FoodFormCameraView()
    }
}
