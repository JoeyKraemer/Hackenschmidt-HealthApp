//
//  WorkoutStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Workout: Codable {
    var workout_id: Int?
    var workout_name: String
    var user_id: UUID?
    var calories: Int?
}
