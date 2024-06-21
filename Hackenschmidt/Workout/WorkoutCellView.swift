import SwiftUI

struct WorkoutCellView: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workout.workout_name)
                .font(.headline)
            ForEach(workout.collection_of_exercise) { exercise in
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.exercise_name)
                        .font(.subheadline)
                    HStack {
                        Text("Sets: \(exercise.sets)")
                        Spacer()
                        Text("Reps: \(exercise.reps)")
                        Spacer()
                        Text("Weight: \(exercise.weight) kg")
                    }
                    .foregroundStyle(Color("TextColor"))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct WorkoutCellView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCellView(workout: Workout(workout_id: UUID(), workout_name: "Sample Workout", collection_of_exercise: [Exercise(exercise_id: UUID(), exercise_name: "Bench Press", sets: 3, reps: 10, weight: 100, muscle_group: "Chest", equipment: "Barbell")], calories: 300))
            .previewLayout(.sizeThatFits)
    }
}
