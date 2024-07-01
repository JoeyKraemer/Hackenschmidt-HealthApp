import SwiftUI

struct AddWorkoutView: View {
    @State private var isAdding: Bool = false
    @State private var supabaseLogic = SupabaseLogic.shared

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        SearchBarView()

                        VStack {
                            Text("My Workouts")
                                .foregroundColor(Color("ButtonColor"))
                                .font(.system(size: 15, weight: .bold))
                        }

                        VStack {
                            if let errorMessage = supabaseLogic.errorMessage {
                                Text(errorMessage).foregroundColor(.red)
                            } else {
                                List(supabaseLogic.workouts, id: \.workout_id) { workout in
                                    WorkoutCellView(
                                        workout: workout,
                                        workoutExercises: supabaseLogic.workoutExercise,
                                        exercises: supabaseLogic.exercises
                                    )
                                }
                                .listStyle(PlainListStyle())
                                .background(Color("NormalBackground"))
                            }
                        }
                        .onAppear {
                            Task {
                                await supabaseLogic.fetchWorkout()
                                await supabaseLogic.fetchExercise()
                                await supabaseLogic.fetchWorkoutExercise()
                            }
                        }
                    }
                    .blur(radius: isAdding ? 5 : 0)
                    .animation(.default, value: isAdding)

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            NavigationLink(destination: AddWorkoutForm()) {
                                Image(systemName: "trophy.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.purple)
                                    .transition(.move(edge: .bottom))
                                    .animation(.easeInOut, value: isAdding)
                            }
                            .padding(.bottom, 30)
                        }
                        .padding(.trailing, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Preview for the SwiftUI view
#Preview {
    AddWorkoutView()
}
