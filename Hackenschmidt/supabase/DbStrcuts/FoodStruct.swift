//
//  FoodStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

import Foundation

struct Food: Codable, Hashable{
  var food_name: String
  var calories: Int8
  var weight: Float16
  var protein: Float16
  var carbohydrates: Float16
  var fat: Float16
  var additional: String
}
