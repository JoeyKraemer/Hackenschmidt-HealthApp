//
//  FoodStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

//this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Food: Codable, Hashable {
    var food_name: String
    var calories: Int8
    var weight: Float16
    var protein: Float16
    var carbohydrates: Float16
    var fat: Float16
    var additional: String
}
