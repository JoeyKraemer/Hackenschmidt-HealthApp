import SwiftUI

struct FoodFormView: View {
    @State private var productName: String = ""
    @State private var productWeight: String = ""
    @State private var carbs: String = ""
    @State private var fat: String = ""
    @State private var protein: String = ""
    @State private var calories: String = ""
    @StateObject private var supabaseLogic = SupabaseLogic()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
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
                            TextField("Weight", text: $productWeight)
                                .frame(width: 313)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Text("kg")
                                            .padding(.trailing, 8)
                                            .foregroundColor(Color("TextColor"))
                                    }
                                )
                        }

                        VStack {
                            Text("Nutrition per 100g")
                                .foregroundStyle(Color("TextColor"))
                            HStack {
                                TextField("Carbs", text: $carbs)
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
                                TextField("Fat", text: $fat)
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
                                TextField("Protein", text: $protein)
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
                            TextField("Calories", text: $calories)
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
                            await saveFood()
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
                }
            }
        }
    }

    private func saveFood() async {
        guard let weight = Float16(productWeight),
              let protein = Float16(protein),
              let carbs = Float16(carbs),
              let fat = Float16(fat),
              let calories = Int8(calories)
        else {
            // Handle invalid input
            return
        }

        await supabaseLogic.appendFood(
            food_name: productName,
            calories: calories,
            weight: weight,
            protein: protein,
            carbohydrates: carbs,
            fat: fat,
            additional: ""
        )

        // Navigate back to AddMealForm
        presentationMode.wrappedValue.dismiss()
    }
}

struct FoodFormView_Previews: PreviewProvider {
    static var previews: some View {
        FoodFormView()
    }
}
