//
//  CalorieCalculator.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 12.06.2024.
//

import Foundation

class CalorieCalculator {
    static let shared = CalorieCalculator()

    var sex: String?
    var age: Int?
    var weight: Int?
    var height: Int?
    var activityLevel: String?
    var goal: String?

    private init() {}

    func setSex(sex: String) {
        self.sex = sex
    }

    func setAge(age: Int) {
        self.age = age
    }

    func setWeight(weight: Int) {
        self.weight = weight
    }

    func setHeight(height: Int) {
        self.height = height
    }

    func setActivityLevel(activityLevel: String) {
        self.activityLevel = activityLevel
    }

    func setGoal(goal: String) {
        self.goal = goal
    }

    func getSex() -> String {
        activityLevel!
    }

    func calculateBaseMetabolicRate() -> Double {
        let weightFactor: Double
        let heightFactor: Double
        let ageFactor: Double
        let baseValue: Double

        switch sex {
        case "Female":
            weightFactor = 9.247 * Double(weight!)
            heightFactor = 3.098 * Double(height!)
            ageFactor = 4.330 * Double(age!)
            baseValue = 447.593
        case "Male":
            weightFactor = 13.397 * Double(weight!)
            heightFactor = 4.799 * Double(height!)
            ageFactor = 5.677 * Double(age!)
            baseValue = 88.362
        default:
            return 0
        }

        return baseValue + weightFactor + heightFactor - ageFactor
    }

    func adjustByActivityLevel() -> Double {
        switch activityLevel {
        case "Not Very Active":
            return calculateBaseMetabolicRate() * 1.2
        case "Active":
            return calculateBaseMetabolicRate() * 1.55
        case "Very Active":
            return calculateBaseMetabolicRate() * 1.725
        default:
            return 0
        }
    }

    func getTotalCalories() -> Int {
        switch goal {
        case "Maintain Weight":
            return Int(adjustByActivityLevel())
        case "Lose Weight":
            return Int(adjustByActivityLevel() - 500)
        case "Grow Muscles":
            return Int(adjustByActivityLevel() + 500)
        default:
            return 0
        }
    }
}
