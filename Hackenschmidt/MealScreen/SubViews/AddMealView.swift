import SwiftUI

struct AddMealView: View {
    @State private var isAdding: Bool = false
    @State private var supabasLogic = SupabaseLogic.shared
    @State private var selectedMeal: Meal? = nil
    @State private var mealFoodItems: [Int: [Food]] = [:]

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        SearchBarView()
                    }

                    VStack {
                        Text("My meals")
                            .foregroundColor(Color("ButtonColor"))
                            .font(.system(size: 15, weight: .bold))
                    }

                    VStack {
                        if supabasLogic.authViewModel.isLoading {
                            ProgressView("Loading...")
                        } else if let errorMessage = supabasLogic.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        } else {
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(supabasLogic.meals, id: \.self) { meal in
                                        VStack(alignment: .leading) {
                                            MealCard(name: meal.meal_name, calories: Int(meal.calories))
                                                .foregroundColor(.black)
                                                .onTapGesture {
                                                    selectedMeal = meal
                                                }
                                        }
                                        .padding()
                                        .background(Color("NormalBackground"))
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .background(Color("NormalBackground"))
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
                    NavigationLink(destination: AddMealForm()) {
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
    AddMealView()
}
