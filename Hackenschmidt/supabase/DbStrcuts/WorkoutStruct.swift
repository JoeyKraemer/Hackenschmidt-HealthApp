//
//  WorkoutStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

import Foundation

struct Workout: Codable {
    var workout_id: UUID?
    var workout_name: String
    var collection_of_exercise: [String]
    var calories: Int
}
