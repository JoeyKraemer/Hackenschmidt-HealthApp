//
//  ExerciseStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

import Foundation

struct Exercise: Codable {
    var exercise_name: String
    var sets: Int
    var reps: Int
    var user_id: UUID
    var weight: Int
    var muscle_group: String
    var equipment: String
}
