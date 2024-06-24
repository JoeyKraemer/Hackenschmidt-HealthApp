//
//  ExerciseCard.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//
import SwiftUI

struct ExerciseCard: View {
    var exercise: Exercise
    @Binding var isChecked: Bool
    
    var body: some View {
        ZStack {
            Color.white // Set the background of the card to white
            HStack {
                Button(action: {
                    isChecked.toggle()
                }) {
                    Image(systemName: isChecked ? "checkmark.square" : "square")
                        .foregroundColor(.purple)
                }
                VStack(alignment: .leading) {
                    
                    Text(exercise.exercise_name)
                        .font(.headline)
                        .foregroundStyle(Color("TextColor"))
                    HStack {
                        if let sets = exercise.sets {
                            Text("Sets: \(sets)")
                                .foregroundStyle(Color("TextColor"))
                        }
                        Spacer()
                        if let reps = exercise.reps {
                            Text("Reps: \(reps)")
                                .foregroundStyle(Color("TextColor"))
                        }
                        Spacer()
                        if let weight = exercise.weight {
                            Text("Weight: \(weight) kg")
                                .foregroundStyle(Color("TextColor"))
                        }
                    }
                }
            }
        }
        .cornerRadius(10)
        .background(Color("NormalBackground"))
    }
}

struct ExerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCard(exercise: Exercise(exercise_id: 1, exercise_name: "Bench Press", user_id: UUID(), sets: 3, reps: 10, weight: 100, muscle_group: "Chest", equipment: "Barbell", calorie_burned: 50), isChecked: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
