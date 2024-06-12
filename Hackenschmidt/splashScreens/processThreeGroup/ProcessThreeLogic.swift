//
//  ProcessThreeLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 04.06.2024.
//

import Foundation

class ProcessThreeChecker {
    func checkGoal(goal: String) -> Bool {
        goal.isEmpty
    }

    func checkCalories(calories: Int) -> Bool {
        calories <= 0
    }

    func checkEmpty(selectedTitle: String, calories: Int) -> Bool {
        if selectedTitle.isEmpty || calories <= 0 {
            return true
        }

        return false
    }
}
