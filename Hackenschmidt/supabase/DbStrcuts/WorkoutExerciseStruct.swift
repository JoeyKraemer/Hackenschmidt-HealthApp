//
//  WorkoutExerciseStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 24.06.24.
//

import Foundation

struct WorkoutExercise: Codable, Hashable {
    var workout_exercise_combination_id: Int?
    var workout_id: Int
    var exercise_id: Int
    var log_id: Int?
}
