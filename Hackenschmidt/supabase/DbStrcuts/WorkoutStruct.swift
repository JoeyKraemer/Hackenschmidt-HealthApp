//
//  WorkoutStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

import Foundation

struct Workout: Codable {
    var workout_id: Int
    var workout_name: String
    var user_id: UUID?
    var calories: Int?
}
