//
//  AddExerciseLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import Foundation

class AddExerciseChecker {
    func checkName(name: String) -> Bool {
        name.isEmpty
    }

    func checkSets(sets: Int) -> Bool {
        sets <= 0
    }

    func checkReps(reps: Int) -> Bool {
        reps <= 0
    }

    func checkWeight(weight: Int) -> Bool {
        weight <= 0
    }

    func checkMuscleGroup(group: String) -> Bool {
        group.isEmpty
    }

    func checkEquipment(equipment: String) -> Bool {
        equipment.isEmpty
    }

    func checkAll(name: String, sets: Int, reps: Int, weight: Int, group: String, equipment: String) -> Bool {
        if name.isEmpty {
            return true
        }

        if sets <= 0 {
            return true
        }

        if reps <= 0 {
            return true
        }

        if weight <= 0 {
            return true
        }

        if group.isEmpty {
            return true
        }

        if equipment.isEmpty {
            return true
        }

        return false
    }
}
