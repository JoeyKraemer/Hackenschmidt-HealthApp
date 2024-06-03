//
//  ProcessTwoLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 03.06.2024.
//

import SwiftUI
import Combine

class ProcessTwoChecker: ObservableObject {
    @Published var weight: Int?
    @Published var height: Int?
    @Published var gender: String?
    @Published var activity: String?

    func setWeight(_ weight: Int?) {
        self.weight = weight
        if isWeightEmpty(weight: weight ?? 0) {
            print("Weight is empty or zero")
        }
    }
    
    func setHeight(_ height: Int?) {
        self.height = height
        if isHeightEmpty(height: height ?? 0) {
            print("Height is empty or zero")
        }
    }

    func setGender(_ gender: String?) {
        self.gender = gender
        if isGenderEmpty(gender: gender ?? "") {
            print("Gender is empty")
        }
    }

    func setActivity(_ activity: String?) {
        self.activity = activity
        if isActivityEmpty(activity: activity ?? "") {
            print("Activity is empty")
        }
    }

    func isWeightEmpty(weight: Int) -> Bool {
        return weight == 0
    }
    
    func isHeightEmpty(height: Int) -> Bool {
        return height == 0
    }
    
    func isGenderEmpty(gender: String) -> Bool {
        return gender.isEmpty
    }
    
    func isActivityEmpty(activity: String) -> Bool {
        return activity.isEmpty
    }
    
    func checkForNil(weight: Int, height: Int, gender: String, activity: String) -> Bool {
        if weight <= 0 {
            return true
        }
        if height <= 0 {
            return true
        }
        if gender.isEmpty {
            return true
        }
        if activity.isEmpty {
            return true
        }

        return false
    }
}

