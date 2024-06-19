//
//  UserProfileStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 19.06.2024.
//

import Foundation

struct UserProfile: Codable {
    var user_id: UUID
    var name: String
    var calorie_goal: Int
    var weight: Int
    var height: Int
    var sex: String
    var activity: String
    var body_goal: String
    var age: Int
}
