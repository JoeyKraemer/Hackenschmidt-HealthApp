//
//  ExerciseCard.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//
import SwiftUI

struct ExerciseCard: View {
    var exercise: Exercise
    @State private var isChecked: Bool = false

    var body: some View {
        HStack {
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .foregroundColor(.purple)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(exercise.exercise_name)
                    .font(.headline)
                    .foregroundColor(.purple)
                HStack {
                    Text("Sets: \(exercise.sets)")
                        .font(.subheadline)
                    Spacer()
                    Text("Reps: \(exercise.reps)")
                        .font(.subheadline)
                    Spacer()
                    Text("Weight: \(exercise.weight) kg")
                        .font(.subheadline)
                }
                .foregroundColor(Color("TextColor"))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ExerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCard(exercise: Exercise(exercise_id: UUID(), exercise_name: "Bench Press", sets: 3, reps: 10, weight: 100, muscle_group: "Chest", equipment: "Barbell"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
