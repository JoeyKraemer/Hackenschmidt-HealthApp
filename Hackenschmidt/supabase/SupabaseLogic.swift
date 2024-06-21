//
//  SupabaseLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//
import Foundation
import SwiftUI

class SupabaseLogic: ObservableObject {
    @StateObject public var authViewModel = AuthViewModel.shared
    @Published var foods: [Food] = []
    @Published var workouts: [Workout] = []
    @Published var exercises: [Exercise] = []
    @Published var meals: [Meal] = []
    @Published var user_profiles: [UserProfile] = []
    @Published var logs: [Log] = []
    @Published var user_loading: Bool = true
    @Published var errorMessage: String? = nil

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
            let response: [Meal] = try await authViewModel.client.from("meals").select().execute().value
            meals = response
            authViewModel.isLoading = false
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }

    func fetchUserProfile() async {
        do {
            let response: [UserProfile] = try await authViewModel.client.from("user_profile").select().execute().value
            user_profiles = response
            print(response)
            print(user_profiles)
            user_loading = false
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
            authViewModel.isLoading = false
        }catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }
    
    func appendMeal(meal_name: String,collection_of_food: [Food],cooking_steps: [String],user_id: UUID, calories: Int) async {
        let newMeal = Meal(
            meal_name: meal_name,
            collection_of_food: collection_of_food,
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

    func appendWorkout(workout_name: String, collection_of_exercises: [Exercise], calories: Int) async -> Bool {
        let newWorkout = Workout(
            workout_id: UUID(),
            workout_name: workout_name,
            collection_of_exercise: collection_of_exercises,
            calories: calories
        )
        do {
            let _ = try await authViewModel.client.from("workouts").insert(newWorkout).execute()
            return true
        } catch {
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
            return false
        }
    }

    func appendExercise(
        exercise_name: String, sets: Int, reps: Int, user_id: UUID, weight: Int, muscle_group: String, equipment: String) async {
        let newExercise = Exercise(
            exercise_name: exercise_name,
            user_id: user_id,
            sets: sets,
            reps: reps,
            weight: weight,
            muscle_group: muscle_group,
            equipment: equipment
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

    func appendUserProfile(
        user_id: UUID, name: String, calorie_goal: Int, weight: Int, height: Int, sex: String, activity: String, body_goal: String, age: Int
    ) async {
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
    
    func appendLog(log_id: UUID, log_date: Date, user_id: UUID, meals: [Meal], workouts: [Workout]) async {
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
}
