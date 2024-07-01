import SwiftUI

struct MealDetailView: View {
    var meal: Meal
    @State private var supabaseLogic = SupabaseLogic.shared
    @State private var foodItems: [Food] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            Text(meal.meal_name)
                .font(.title)
                .padding()

            Text("Calories: \(meal.calories)")
                .padding()

            Text("Cooking Steps:")
                .font(.headline)
                .padding(.top)

            Text(meal.cooking_steps)
                .padding()

            Text("Collection of Food:")
                .font(.headline)
                .padding(.top)

            if isLoading {
                ProgressView("Loading food items...")
            } else if let errorMessage = errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
                ForEach(foodItems, id: \.self) { food in
                    Text(food.food_name)
                        .padding(.vertical, 2)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            loadFoodItems()
        }
    }

    func loadFoodItems() {
        isLoading = true
        errorMessage = nil
        Task {
            if let fetchedFoodItems = await supabaseLogic.fetchFoodItems(for: meal.meal_id) {
                foodItems = fetchedFoodItems
            } else {
                errorMessage = supabaseLogic.errorMessage
            }
            isLoading = false
        }
    }
}
