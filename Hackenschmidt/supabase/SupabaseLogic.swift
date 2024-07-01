//
//  SupabaseLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//
import Foundation
import SwiftUI

class SupabaseLogic: Observable {
    @State public var authViewModel = AuthViewModel.shared
    @Published var foods: [Food] = []
    @Published var workouts: [Workout] = []
    @Published var exercises: [Exercise] = []
    @Published var meals: [Meal] = []
    @Published var workoutExercise: [WorkoutExercise] = []
    @Published var user_profiles: [UserProfile] = []
    @Published var logs: [Log] = []
    @Published var user_loading: Bool = true
    @Published var errorMessage: String? = nil
    
    static let shared = SupabaseLogic()

    func fetchFoods() async {
        authViewModel.isLoading = true
        do {
            let response: [Food] = try await authViewModel.client.from("food").select().execute().value
            foods = response
            authViewModel.isLoading = false
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchMeals() async {
        authViewModel.isLoading = true
        do {
            let response: [Meal] = try await authViewModel.client
                .from("meals")
                .select()
                .execute()
                .value
            meals = response
            print("Hello", response)
            authViewModel.isLoading = false
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func appendMeal(
        meal_id: Int,
        meal_name: String,
        cooking_steps: String,
        user_id: UUID,
        calories: Int
    ) async {
        let newMeal = Meal(
            meal_id: meal_id,
            meal_name: meal_name,
            cooking_steps: cooking_steps,
            user_id: user_id,
            calories: calories
        )

        do {
            let _ = try await authViewModel.client.from("meals").insert(newMeal).execute()
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchUserProfile() async {
        self.user_loading = true
        do {
            let response: [UserProfile] = try await authViewModel.client.from("user_profile").select().execute().value
            user_profiles = response
            print(response)
            print(user_profiles)
            self.user_loading = false
            print("finished loading...")
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.user_loading = false
            }
        }
    }

    func fetchLog() async {
        authViewModel.isLoading = true
        do {
            let response: [Log] = try await authViewModel.client.from("logs").select().execute().value
            logs = response
            authViewModel.isLoading = false
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchWorkout() async {
        authViewModel.isLoading = true
        do {
            let response: [Workout] = try await authViewModel.client.from("workouts").select().execute().value
            workouts = response
            authViewModel.isLoading = false
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchExercise() async {
        authViewModel.isLoading = true
        do {
            let response: [Exercise] = try await authViewModel.client.from("exercise").select().execute().value
            exercises = response
            DispatchQueue.main.async {
                self.authViewModel.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchWorkoutExercise() async {
        authViewModel.isLoading = true
        do {
            let response: [WorkoutExercise] = try await authViewModel.client.from("workouts_exercises").select().execute().value
            workoutExercise = response
            DispatchQueue.main.async {
                self.authViewModel.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func appendFood(
        food_name: String, calories: Int8, weight: Float16, protein: Float16, carbohydrates: Float16,
        fat: Float16, additional: String
    ) async {
        let newFood = Food(
            food_name: food_name,
            calories: calories,
            weight: weight,
            protein: protein,
            carbohydrates: carbohydrates,
            fat: fat,
            additional: additional
        )
        do {
            let _ = try await authViewModel.client.from("food").insert(newFood).execute()
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func appendWorkout(workout_id: Int? = nil, workout_name: String, user_id: UUID, calories: Int? = nil) async -> Bool {
        let newWorkout = Workout(
            workout_id: workout_id,
            workout_name: workout_name,
            user_id: user_id,
            calories: calories
        )
        do {
            let _ = try await authViewModel.client.from("workouts").insert(newWorkout).execute()
            return true
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription, "1111")
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
            return false
        }
    }

    func appendExercise(exercise_id: Int? = nil, exercise_name: String, sets: Int, reps: Int, user_id: UUID, weight: Int, muscle_group: String, equipment: String, calorie_burned: Int) async {
        let newExercise = Exercise(
            exercise_id: exercise_id,
            exercise_name: exercise_name,
            user_id: user_id,
            sets: sets,
            reps: reps,
            weight: weight,
            muscle_group: muscle_group,
            equipment: equipment,
            calorie_burned: calorie_burned
        )
        do {
            let _ = try await
                authViewModel.client.from("exercise").insert(newExercise).execute()
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func appendWorkoutExercise(workout_exercise_combination_id: Int? = nil, workout_id: Int, exercise_id: Int, log_id: Int? = nil) async -> Bool {
        let newExercise = WorkoutExercise(
            workout_exercise_combination_id: workout_exercise_combination_id,
            workout_id: workout_id,
            exercise_id: exercise_id,
            log_id: log_id
        )
        do {
            let _ = try await authViewModel.client.from("workouts_exercises").insert(newExercise).execute()
            return true
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription, "112244")
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
            return false
        }
    }

    func appendUserProfile(user_id: UUID, name: String, calorie_goal: Int, weight: Int, height: Int, sex: String, activity: String, body_goal: String, age: Int) async {
        let newUserProfile = UserProfile(
            user_id: user_id,
            name: name,
            calorie_goal: calorie_goal,
            weight: weight,
            height: height,
            sex: sex,
            activity: activity,
            body_goal: body_goal,
            age: age
        )
        do {
            let _ = try await
                authViewModel.client.from("user_profile").insert(newUserProfile).execute()
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func appendLog(log_id: UUID, log_date: Date, user_id _: UUID, meals: [Meal], workouts: [Workout]) async {
        let newLog = Log(
            log_id: log_id,
            log_date: log_date,
            meals: meals,
            workouts: workouts
        )
        do {
            let _ = try await
                authViewModel.client.from("logs").insert(newLog).execute()
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func updateUserProfile(user_id: UUID, name: String, calorie_goal: Int, weight: Int, height: Int, sex: String, activity: String, body_goal: String, age: Int) async {
        let updatedUserProfile = UserProfile(
            name: name,
            calorie_goal: calorie_goal,
            weight: weight,
            height: height,
            sex: sex,
            activity: activity,
            body_goal: body_goal,
            age: age
        )

        do {
            let _ = try await authViewModel.client.from("user_profile").update(updatedUserProfile)
                .eq("user_id", value: user_id).execute()
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func updateLog(log_id: UUID, log_date: Date, user_id: UUID, meals: [Meal], workouts: [Workout]) async {
        let updateLog = Log(
            log_id: log_id,
            log_date: log_date,
            user_id: user_id,
            meals: meals,
            workouts: workouts
        )
        do {
            let _ = try await authViewModel.client.from("logs").update(updateLog)
                .eq("log_id", value: log_id).execute()
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchMealFoodStructs(for mealId: Int) async -> [MealFoodStruct]? {
        do {
            let response: [MealFoodStruct] = try await authViewModel.client
                .from("meals_foods")
                .select()
                .eq("meal_id", value: mealId)
                .execute()
                .value
            return response
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            return nil
        }
    }

    func fetchFoods(for foodIds: [Int]) async -> [Food]? {
        do {
            let response: [Food] = try await authViewModel.client
                .from("food")
                .select()
                .in("food_id", values: foodIds)
                .execute()
                .value
            return response
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            return nil
        }
    }

    func fetchFoodItems(for mealId: Int) async -> [Food]? {
        guard let mealFoodStructs = await fetchMealFoodStructs(for: mealId) else {
            return nil
        }

        let foodIds = mealFoodStructs.map { $0.food_id }
        return await fetchFoods(for: foodIds)
    }
}
