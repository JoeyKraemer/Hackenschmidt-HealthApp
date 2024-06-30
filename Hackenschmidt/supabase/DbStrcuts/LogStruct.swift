//
//  LogStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

//this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Log: Codable {
    var log_id: UUID?
    var log_date: Date
    var user_id: UUID?
    var meals: [Meal]
    var workouts: [Workout]
}
