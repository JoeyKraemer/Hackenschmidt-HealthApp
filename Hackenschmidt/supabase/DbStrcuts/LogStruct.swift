//
//  LogStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

import Foundation

struct Log: Codable {
    var log_id: UUID?
    var log_date: String
    var user_id: UUID?
    var meals: [Meal]
    var workouts: [Workout]
}
