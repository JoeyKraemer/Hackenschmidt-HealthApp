//
//  ExerciseStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
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
