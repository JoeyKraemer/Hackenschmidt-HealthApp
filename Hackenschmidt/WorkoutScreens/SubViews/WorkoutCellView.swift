import SwiftUI

struct WorkoutCellView: View {
    var workout: Workout
    var workoutExercises: [WorkoutExercise]
    var exercises: [Exercise]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            let filteredWorkoutExercises = workoutExercises.filter { $0.workout_id == workout.workout_id }
            let workoutName = workout.workout_name
            Text(workoutName)
                .font(.headline)

            ForEach(filteredWorkoutExercises, id: \.workout_exercise_combination_id) { workoutExercise in
                if let exercise = exercises.first(where: { $0.exercise_id == workoutExercise.exercise_id }) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(exercise.exercise_name)
                            .font(.subheadline)
                        HStack {
                            Text("Sets: \(String(describing: exercise.sets))")
                            Spacer()
                            Text("Reps: \(String(describing: exercise.reps))")
                            Spacer()
                            Text("Weight: \(String(describing: exercise.weight)) kg")
                        }
                        .foregroundColor(Color("TextColor"))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
