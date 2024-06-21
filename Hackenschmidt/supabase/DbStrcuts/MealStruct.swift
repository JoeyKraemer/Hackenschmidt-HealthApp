//
//  MealStruct.swift
//  Hackenschmidt
//
//  Created by Vladislav Kitsak on 21.06.2024.
//

import Foundation

struct Meal: Codable, Hashable {
    var meal_name: String
    var collection_of_food: [Food]
    var cooking_steps: [String]
    var user_id: UUID
    var calories: Int
}
