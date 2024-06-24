import SwiftUI

struct AddWorkoutForm: View {
    @State private var workoutName: String = ""
    @State private var exercises: [Exercise] = []
    @State private var addedExercises: [Exercise] = []
    @State private var checkedStates: [Int: Bool] = [:]
    @State private var isLoading = true
    @State private var isSaving = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldNavigate = false
    
    @StateObject private var supabaseLogic = SupabaseLogic()
    @StateObject private var authViewModel = AuthViewModel.shared

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("What is the Workout's name?")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            TextField("Name?", text: $workoutName)
                                .frame(width: 313)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                        
                        VStack(alignment: .leading) {
                            Text("Add Exercise")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            NavigationLink(destination: AddExercise(workoutName: $workoutName)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.0))
                                        .frame(width: 340, height: 70)
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black)
                                        .frame(width: 340, height: 70)
                                    
                                    Text("Add an exercise")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color("TextColor"))
                                        .frame(width: 340, height: 70, alignment: .center)
                                }
                            }
                            .frame(width: 340, height: 70)
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Exercise list")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            
                            if supabaseLogic.exercises.isEmpty {
                                Text("No exercises added")
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 20)
                            } else {
                                List(exercises, id: \.exercise_id) { exercise in
                                    ExerciseCard(
                                        exercise: exercise,
                                        isChecked: Binding(
                                            get: { checkedStates[exercise.exercise_id!] ?? false },
                                            set: { checkedStates[exercise.exercise_id!] = $0 }
                                        )
                                    )
                                }
                                .listStyle(PlainListStyle())
                            }
                        }
                        .padding()
                        .frame(height: 400)
                        
                        // Added Exercises List
                        VStack(alignment: .leading) {
                            Text("Added exercises")
                                .foregroundColor(Color("TextColor"))
                                .padding(.bottom, 20)
                            
                            if addedExercises.isEmpty {
                                Text("No exercises added yet")
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 20)
                            } else {
                                List(addedExercises, id: \.exercise_id) { exercise in
                                    Text(exercise.exercise_name)
                                        .foregroundColor(Color("TextColor"))
                                }
                                .listStyle(PlainListStyle())
                            }
                        }
                        .padding()
                        .frame(height: 200)
                        
                        // Button to add checked exercises
                        Button(action: {
                            for exercise in exercises {
                                if checkedStates[exercise.exercise_id!] == true {
                                    if !addedExercises.contains(where: { $0.exercise_id == exercise.exercise_id }) {
                                        addedExercises.append(exercise)
                                    }
                                }
                            }
                        }) {
                            Text("ADD CHECKED EXERCISES")
                                .frame(width: 340, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color("ButtonColor"))
                                .cornerRadius(5)
                        }
                        .padding(.bottom, 10)
                        
                        Spacer()
                        
                        NavigationLink(destination: Homepage(), isActive: $shouldNavigate) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            Task {
                                isSaving = true
                                let success = await saveWorkoutAndExercises()
                                isSaving = false
                                if success {
                                    workoutName = ""
                                    addedExercises.removeAll()
                                    alertMessage = "Workout added successfully!"
                                    shouldNavigate = true
                                } else {
                                    alertMessage = "Failed to add workout."
                                    showAlert = true
                                }
                                
                            }
                        }) {
                            Text("ADD WORKOUT")
                                .frame(width: 340, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color("ButtonColor"))
                                .cornerRadius(5)
                        }
                        .disabled(workoutName.isEmpty || isSaving)
                        .opacity(workoutName.isEmpty || isSaving ? 0.5 : 1.0)
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertMessage))
                    }
                }
            }
            .onAppear {
                Task {
                    await supabaseLogic.fetchExercise()
                    exercises = supabaseLogic.exercises
                    print("Fetched exercises: \(supabaseLogic.exercises)")
                    isLoading = false
                }
            }
        }
    }
    
    private func saveWorkoutAndExercises() async -> Bool {
        guard let userId = authViewModel.uid else {
            return false
        }

        let workoutAdded = await supabaseLogic.appendWorkout(workout_name: workoutName, user_id: userId)
        if !workoutAdded {
            return false
        }
        
        guard let newWorkout = supabaseLogic.workouts.last else {
            return false
        }
        
        for exercise in addedExercises {
            let workoutExerciseAdded = await supabaseLogic.appendWorkoutExercise(
                workout_exercise_combination_id: Int.random(in: 1...Int.max),
                workout_id: newWorkout.workout_id,
                exercise_id: exercise.exercise_id!,
                log_id: 0
            )
            if !workoutExerciseAdded {
                return false
            }
        }
        return true
    }
}

#Preview {
    AddWorkoutForm()
}
