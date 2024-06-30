//
//  WorkoutExerciseStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 24.06.24.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct WorkoutExercise: Codable, Hashable {
    var workout_exercise_combination_id: Int?
    var workout_id: Int
    var exercise_id: Int
    var log_id: Int?
}
