import SwiftUI

struct AddMealForm: View {
    @State private var mealName: String = ""
    @State private var foods: [Food] = []
    @State private var addedFoods: [Food] = []
    @State private var checkedStates: [Int: Bool] = [:]
    @State private var isLoading = true
    @State private var isSaving = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldNavigate = false

    @State private var supabaseLogic = SupabaseLogic.shared
    @State private var authViewModel = AuthViewModel.shared

    var body: some View {
        NavigationStack {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("What is the Meal’s name?")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            TextField("Name?", text: $mealName)
                                .frame(width: 313)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)
                        .padding(.top, 50)

                        VStack(alignment: .leading) {
                            Text("Add Ingredient")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            NavigationLink(destination: ProductFormView(mealName: $mealName)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.0))
                                        .frame(width: 340, height: 70)

                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black)
                                        .frame(width: 340, height: 70)

                                    Text("Add a food item")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color("TextColor"))
                                        .frame(width: 340, height: 70, alignment: .center)
                                }
                            }
                            .frame(width: 340, height: 70)
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: FoodFormCameraView(mealName: $mealName)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.0))
                                        .frame(width: 340, height: 70)

                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black)
                                        .frame(width: 340, height: 70)

                                    Text("Add a food item with camera")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color("TextColor"))
                                        .frame(width: 340, height: 70, alignment: .center)
                                }
                            }
                            .frame(width: 340, height: 70)
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        

                        VStack(alignment: .leading) {
                            Text("Food list")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)

                            if supabaseLogic.foods.isEmpty {
                                Text("No food items available")
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 20)
                            } else {
                                List(foods, id: \.food_id) { food in
                                    FoodCard(
                                        food: food,
                                        isChecked: Binding(
                                            get: { checkedStates[food.food_id!] ?? false },
                                            set: { checkedStates[food.food_id!] = $0 }
                                        )
                                    )
                                }
                                .listStyle(PlainListStyle())
                            }
                        }
                        .padding()
                        .frame(height: 400)

                        // Added Foods List
                        VStack(alignment: .leading) {
                            Text("Added foods")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)

                            if addedFoods.isEmpty {
                                Text("No foods added yet")
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 20)
                            } else {
                                List(addedFoods, id: \.food_id) { food in
                                    Text(food.food_name)
                                        .foregroundColor(Color("TextColor"))
                                }
                                .listStyle(PlainListStyle())
                            }
                        }
                        .padding()
                        .frame(height: 200)

                        // Button to add checked foods
                        Button(action: {
                            for food in foods {
                                if checkedStates[food.food_id!] == true {
                                    if !addedFoods.contains(where: { $0.food_id == food.food_id }) {
                                        addedFoods.append(food)
                                    }
                                }
                            }
                        }) {
                            Text("ADD CHECKED FOODS")
                                .frame(width: 340, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color("ButtonColor"))
                                .cornerRadius(5)
                        }
                        .padding(.bottom, 10)

                        Spacer()
                            .navigationDestination(isPresented: $shouldNavigate) {
                                Homepage()
                            }
                        Button(action: {
                            Task {
                                isSaving = true
                                let success = await saveMealAndFoods()
                                isSaving = false
                                if success {
                                    mealName = ""
                                    addedFoods.removeAll()
                                    alertMessage = "Meal added successfully!"
                                    shouldNavigate = true
                                } else {
                                    alertMessage = "Failed to add meal."
                                    showAlert = true
                                }
                            }
                        }) {
                            Text("ADD MEAL")
                                .frame(width: 340, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color("ButtonColor"))
                                .cornerRadius(5)
                        }
                        .disabled(mealName.isEmpty || isSaving)
                        .opacity(mealName.isEmpty || isSaving ? 0.5 : 1.0)
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertMessage))
                    }
                }
            }
            .onAppear {
                Task {
                    await supabaseLogic.fetchFoods()
                    foods = supabaseLogic.foods
                    print("Fetched foods: \(supabaseLogic.foods)")
                    isLoading = false
                }
            }
        }
    }

    private func saveMealAndFoods() async -> Bool {
        guard let userId = authViewModel.uid else {
            return false
        }

        let mealAdded = await supabaseLogic.appendMeal(meal_name: mealName, cooking_steps: "", user_id: userId, calories: 0)
        
        if !mealAdded {
            return false
        }

        await supabaseLogic.fetchMeals()
        guard let newMeal = supabaseLogic.meals.last else {
            print("newMeal triggered")
            return false
        }

        for food in addedFoods {
            let mealFoodAdded = await supabaseLogic.appendMealFood(
                meal_food_combination_id: nil,
                meal_id: newMeal.meal_id!,
                food_id: food.food_id!
            )
            if !mealFoodAdded {
                print("mealFoodAdded")
                return false
            }
        }
        return true
    }
}
