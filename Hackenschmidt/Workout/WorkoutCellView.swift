//
//  WorkoutCellView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 28.05.24.
//

import SwiftUI

struct WorkoutCellView: View {
    var workout: Workout
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(workout.exercise)
                    .font(.headline)
                ForEach(0..<workout.sets.count, id: \.self) { index in
                    HStack {
                        Text("Set \(index + 1):")
                        Spacer()
                        Text("\(workout.sets[index].weight) kg x \(workout.sets[index].reps) reps")
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct WorkoutCellView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCellView(workout: Workout(exercise: "Bench Press", sets: [(0, 20), (20, 8), (20, 8), (20, 8)]))
            .previewLayout(.sizeThatFits)
    }
}
