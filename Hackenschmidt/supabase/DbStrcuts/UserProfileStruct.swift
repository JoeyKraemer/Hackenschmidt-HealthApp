//
//  UserProfileStruct.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 19.06.2024.
//

//this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct UserProfile: Codable, Hashable {
    var user_id: UUID?
    var name: String
    var calorie_goal: Int
    var weight: Int
    var height: Int
    var sex: String
    var activity: String
    var body_goal: String
    var age: Int
}
