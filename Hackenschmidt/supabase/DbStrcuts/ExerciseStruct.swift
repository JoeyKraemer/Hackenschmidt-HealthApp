//
//  ExerciseStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

import Foundation

struct Exercise: Codable {
    var exercise_id: Int?
    var exercise_name: String
    var user_id: UUID?
    var sets: Int?
    var reps: Int?
    var weight: Int?
    var muscle_group: String?
    var equipment: String?
    var calorie_burned: Int?
}
