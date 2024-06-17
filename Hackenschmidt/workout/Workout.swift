//
//  Workout.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 28.05.24.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    let exercise: String
    let sets: [(weight: Int, reps: Int)]
}
