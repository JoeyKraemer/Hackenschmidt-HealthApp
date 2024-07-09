//
//  ProductFormView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 30.05.24.
//

import SwiftUI

struct ProductFormView: View {
    @Binding var mealName: String
    @State private var productName: String = ""
    @State private var productWeight: Float = 0
    @State private var carbs: Float = 0
    @State private var fat: Float = 0
    @State private var protein: Float = 0
    @State private var calories: Int = 0
    @State private var shouldNavigate = false

    @State private var supabaseLogic = SupabaseLogic.shared

    var body: some View {
        NavigationStack {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        VStack {
                            VStack {
                                Text("What is the product name?")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Name", text: $productName)
                                    .frame(width: 313)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                            }

                            VStack {
                                Text("What is the product weight?")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Weight", text: Binding(
                                    get: { "\(productWeight)" },
                                    set: {
                                        if let value = Float($0) {
                                            productWeight = value
                                        }
                                    }
                                ))
                                .frame(width: 313)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Text("g")
                                            .padding(.trailing, 8)
                                            .foregroundColor(Color("TextColor"))
                                    }
                                )
                            }

                            VStack {
                                Text("Nutrition per 100g")
                                    .foregroundStyle(Color("TextColor"))
                                HStack {
                                    TextField("Carbs", text: Binding(
                                        get: { "\(carbs)" },
                                        set: {
                                            if let value = Float($0) {
                                                carbs = value
                                            }
                                        }
                                    ))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Text("g")
                                                .padding(.trailing, 8)
                                                .foregroundColor(Color("TextColor"))
                                        }
                                    )
                                }

                                HStack {
                                    TextField("Fat", text: Binding(
                                        get: { "\(fat)" },
                                        set: {
                                            if let value = Float($0) {
                                                fat = value
                                            }
                                        }
                                    ))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Text("g")
                                                .padding(.trailing, 8)
                                                .foregroundColor(Color("TextColor"))
                                        }
                                    )
                                }

                                HStack {
                                    TextField("Protein", text: Binding(
                                        get: { "\(protein)" },
                                        set: {
                                            if let value = Float($0) {
                                                protein = value
                                            }
                                        }
                                    ))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Text("g")
                                                .padding(.trailing, 8)
                                                .foregroundColor(Color("TextColor"))
                                        }
                                    )
                                }
                            }
                            .padding()

                            VStack {
                                Text("Calorie on 100g")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Calories", text: Binding(
                                    get: { "\(calories)" },
                                    set: {
                                        if let value = Int($0) {
                                            calories = value
                                        }
                                    }
                                ))
                                .frame(width: 313)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Text("kcal")
                                            .padding(.trailing, 8)
                                            .foregroundColor(Color("TextColor"))
                                    }
                                )
                            }
                        }
                        Spacer()
                        Spacer()

                        Button(action: {
                            Task {
                                await supabaseLogic.appendFood(food_name: productName, calories: calories, weight: productWeight, protein: protein, carbohydrates: carbs, fat: fat, additional: "TBD")
                                print("Processed")
                                shouldNavigate = true
                            }
                        }) {
                            Text("ADD")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        .navigationDestination(isPresented: $shouldNavigate) {
                            AddMealForm()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
