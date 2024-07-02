//
//  DailyLog.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//
import SwiftUI

struct DailyLog: View {
    let log_id: Int
    let date: String
    @State private var isLoading = true
    @State private var supabasLogic = SupabaseLogic.shared
    @State private var isAdding: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text(date)
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()

                HStack {
                    Text("Calories")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding(.top)
                    Spacer()
                }
                .padding(.horizontal)
                CalorieSlider(goal: 3000, food: 1750, burned: 700)

                Spacer()
            }
            .frame(height: 340)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
            .blur(radius: isAdding ? 10 : 0)
            .animation(.default, value: isAdding)

            VStack(alignment: .leading) {
                Text("Meal list")
                    .font(.headline)
                    .padding(.bottom, 5)
                if isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = supabasLogic.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    LazyVStack {
                        ForEach(Array(supabasLogic.mealsByLogId.enumerated()), id: \.offset) { _, mealGroup in
                            ForEach(mealGroup) { meal in
                                MealItemView(name: meal.meal_name, details: meal.cooking_steps, calories: meal.calories)
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                Task {
                    await supabasLogic.fetchUserProfile()
                    await supabasLogic.fetchMealById(log_id: log_id)
                    await supabasLogic.fetchWorkoutExercise()
                    await supabasLogic.fetchWorkout()
                    await supabasLogic.fetchExercise()
                    isLoading = false
                }
            }
        }
    }
}

struct CircularProgressView: View {
    var remaining: Int
    var goal: Int
    var food: Int
    var burned: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(Double(remaining) / Double(goal), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.purple)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: remaining)

            VStack {
                Text("\(remaining)")
                    .font(.largeTitle)
                Text("Remaining")
                    .font(.subheadline)
            }
        }
    }
}

struct MealItemView: View {
    var name: String
    var details: String
    var calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(details)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
            Text("\(calories) cal")
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct WorkoutItemView: View {
    var name: String
    var details: String
    var calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(details)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
            Text("\(calories) cal")
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
