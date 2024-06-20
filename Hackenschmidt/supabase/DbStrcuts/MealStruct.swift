//
//  MealStruct.swift
//  Hackenschmidt
//
//  Created by Vladislav Kitsak on 21.06.2024.
//

import Foundation

struct Meal: Codable, Hashable {
    let meal_name: String
    let collection_of_food: [Food]
    let cooking_steps: [String]
    let user_id: UUID
}
