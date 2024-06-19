//
//  UserProfileGather.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 19.06.2024.
//

import Foundation

class UserProfileInformationGather {
    static let shared = UserProfileInformationGather()

    var name: String?
    var weight: Int?
    var height: Int?
    var sex: String?
    var activity: String?
    var age: Int?

    private init() {}

    func setName(name: String) {
        self.name = name
    }

    func setWeight(weight: Int) {
        self.weight = weight
    }

    func setHeight(height: Int) {
        self.height = height
    }

    func setSex(sex: String) {
        self.sex = sex
    }

    func setActivity(activity: String) {
        self.activity = activity
    }

    func setAge(age: Int) {
        self.age = age
    }

    func getAllInformation() -> (name: String, weight: Int, height: Int, sex: String, activity: String, age: Int) {
        (name: name!, weight: weight!, height: height!, sex: sex!, activity: activity!, age: age!)
    }
}
