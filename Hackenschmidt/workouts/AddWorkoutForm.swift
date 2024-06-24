import SwiftUI

struct AddWorkoutForm: View {
    @State private var workoutName: String = ""
    @State private var exercises: [Exercise] = []
    @StateObject private var supabaseLogic = SupabaseLogic()
    @State private var isLoading = true
    @State private var isSaving = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldNavigate = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack(alignment: .leading) {
                        Text("What is the Workout's name?")
                            .foregroundStyle(Color("TextColor"))
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
                            .foregroundStyle(Color("TextColor"))
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
                            .foregroundStyle(Color("TextColor"))
                            .padding(.bottom, 20)

                        if exercises.isEmpty {
                            Text("No exercises added")
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 20)
                        } else {
                            List(exercises) { exercise in
                                ExerciseCard(exercise: exercise)
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                    .padding()

                    Spacer()

                    NavigationLink(destination: Homepage(), isActive: $shouldNavigate) {
                        EmptyView()
                    }

                    Button(action: {
                        Task {
                            isSaving = true
                            let success = await supabaseLogic.appendWorkout(workout_name: workoutName, collection_of_exercises: exercises, calories: 0)
                            isSaving = false
                            if success {
                                workoutName = ""
                                exercises.removeAll()
                                alertMessage = "Workout added successfully!"
                                shouldNavigate = true
                            } else {
                                alertMessage = "Failed to add workout."
                                showAlert = true
                            }
                        }
                    }) {
                        Text("ADD")
                            .frame(width: 340, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(5)
                    }
                    .disabled(workoutName.isEmpty || isSaving) // Disable the button if workoutName is empty or saving
                    .opacity(workoutName.isEmpty || isSaving ? 0.5 : 1.0) // Change the opacity based on the button state
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                guard let userId = supabaseLogic.authViewModel.uid else { return }
                await supabaseLogic.fetchExercise(userId: userId)
                exercises = supabaseLogic.exercises
                isLoading = false
            }
        }
    }
}

#Preview {
    AddWorkoutForm()
}
