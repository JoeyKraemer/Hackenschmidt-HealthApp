//
//  SupabaseLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//
import Foundation
import SwiftUI

class SupabaseLogic: ObservableObject {
    @StateObject private var authViewModel = AuthViewModel.shared 
    @Published var foods: [Food] = []
    @Published var isLoading = false
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
          additional: additional)
        do {
            let _ = try await authViewModel.client.from("food").insert(newFood).execute()
        } catch {
          DispatchQueue.main.async {
              self.authViewModel.errorMessage = error.localizedDescription
              self.authViewModel.isLoading = false
          }
        }
      }
    
    func appendExercise(
        exercise_name: String, sets: Int, user_id: UUID, weight: Int, muscle_group: String, equipment: String
    ) async{
        let newExercise = Exercise(
            exercise_name: exercise_name,
            sets: sets,
            user_id: user_id,
            weight: weight,
            muscle_group: muscle_group,
            equipment: equipment
        )
        do{
            let _ = try await
            authViewModel.client.from("exercise").insert(newExercise).execute()
        }catch{
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }
    
    func appendUserProfile(
        user_id: UUID, name: String, calorie_goal: Int, weight: Int, height: Int, sex: String, activity: String, body_goal: String, age: Int
    ) async{
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
        do{
            let _ = try await
            authViewModel.client.from("user_profile").insert(newUserProfile).execute()
        }catch{
            DispatchQueue.main.async {
                self.authViewModel.errorMessage = error.localizedDescription
                self.authViewModel.isLoading = false
            }
        }
    }
    
    //usage
//    Task{
//        await supabaseLogic.appendUserProfile(user_id: authViewModel.uid!, name: "name", calorie_goal: 100, weight: 1, height: 1, sex: "Female", activity: "active", body_goal: "muscle_growth", age: 100)
//    }
}
