//
//  WorkoutChartView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 28.05.24.
//

import SwiftUI
import Charts

struct WorkoutData: Identifiable {
    let id = UUID()
    let day: String
    let count: Int
}

struct WorkoutChartView: View {
    var workoutData: [WorkoutData]
    
    var body: some View {
        Chart(workoutData) { data in
            LineMark(
                x: .value("Day", data.day),
                y: .value("Count", data.count)
            )
            .foregroundStyle(.purple)
        }
        .frame(height: 200)
        .padding()
    }
}

struct WorkoutChartView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutChartView(workoutData: [
            WorkoutData(day: "Day 9", count: 1),
            WorkoutData(day: "Day 10", count: 2),
            WorkoutData(day: "Day 11", count: 3),
            WorkoutData(day: "Day 12", count: 4),
            WorkoutData(day: "Day 13", count: 2),
            WorkoutData(day: "Day 14", count: 1),
            WorkoutData(day: "Day 15", count: 3),
            WorkoutData(day: "Day 16", count: 0),
            WorkoutData(day: "Day 17", count: 0),
            WorkoutData(day: "Day 18", count: 3),
            WorkoutData(day: "Day 19", count: 3),
            WorkoutData(day: "Day 20", count: 4)
        ])
    }
}
