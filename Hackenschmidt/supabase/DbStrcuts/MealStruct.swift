//
//  MealStruct.swift
//  Hackenschmidt
//
//  Created by Vladislav Kitsak on 21.06.2024.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Meal: Codable, Hashable, Identifiable {
    let meal_id: Int
    let meal_name: String
    let cooking_steps: String
    let user_id: UUID
    let calories: Int

    var id: Int {
        meal_id
    }
}
