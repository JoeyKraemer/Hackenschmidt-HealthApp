//
//  MealFoodStruct.swift
//  Hackenschmidt
//
//  Created by Vladislav Kitsak on 24.06.2024.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import SwiftUI

struct MealFoodStruct: Codable, Hashable {
    var meal_id: Int
    var food_id: Int
    var log_id: Int
}
