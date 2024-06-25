import SwiftUI

struct AddMealUI: View {
    @State private var isAdding: Bool = false
    @StateObject private var supabasLogic = SupabaseLogic()
    @State private var selectedMeal: Meal? = nil
    @State private var mealFoodItems: [Int: [Food]] = [:]

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        SearchBar()
                    }

                    VStack {
                        Text("My meals")
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 15, weight: .bold))
                    }

                    VStack {
                        if supabasLogic.authViewModel.isLoading {
                            ProgressView("Loading...")
                        } else if let errorMessage = supabasLogic.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        } else {
                            List(supabasLogic.meals, id: \.self) { meal in
                                VStack(alignment: .leading) {
                                    MealCard(name: meal.meal_name, calories: Int(meal.calories))
                                        .listRowBackground(Color.clear)
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            selectedMeal = meal
                                        }

                                    if let foods = mealFoodItems[meal.meal_id] {
                                        ForEach(foods, id: \.self) { food in
                                            Text(food.food_name)
                                                .padding(.vertical, 2)
                                        }
                                    } else {
                                        ProgressView()
                                            .onAppear {
                                                Task {
                                                    if let foods = await supabasLogic.fetchFoodItems(for: meal.meal_id) {
                                                        mealFoodItems[meal.meal_id] = foods
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                    .onAppear {
                        Task {
                            await supabasLogic.fetchMeals()
                        }
                    }
                }
                .blur(radius: isAdding ? 5 : 0)
                .animation(.default, value: isAdding)

                VStack {
                    if isAdding {
                        Button(action: {}) {
                            VStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.purple)
                                Text("Manual")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.trailing, 20)

                        Button(action: {}) {
                            VStack {
                                Image(systemName: "camera.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.purple)
                                Text("Camera")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.trailing, 20)
                    }

                    Button(action: {
                        withAnimation {
                            self.isAdding.toggle()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.purple)
                    }
                    .padding(.bottom, 30)
                    .padding(.trailing, 20)
                }
            }
            .sheet(item: $selectedMeal) { meal in
                MealDetailView(meal: meal)
            }
        }
    }
}

// Preview for the SwiftUI view
#Preview {
    AddMealUI()
}
