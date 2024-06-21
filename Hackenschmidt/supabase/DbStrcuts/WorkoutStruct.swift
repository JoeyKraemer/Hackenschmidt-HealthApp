//
//  WorkoutStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

import Foundation

struct Workout: Codable, Identifiable {
    var id: UUID { workout_id ?? UUID() }
    var workout_id: UUID?
    var workout_name: String
    var collection_of_exercise: [Exercise]
    var calories: Int
}
