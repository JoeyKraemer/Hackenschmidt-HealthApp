//
//  FoodStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Food: Codable, Hashable {
    var food_id: Int?
    var food_name: String
    var calories: Int
    var weight: Float
    var protein: Float
    var carbohydrates: Float
    var fat: Float
    var additional: String
}
