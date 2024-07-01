import SwiftUI

struct WorkoutView: View {
    @State private var supabaseLogic = SupabaseLogic.shared
    @State private var isLoading = true
    @State private var isAdding: Bool = false

    var workoutData: [WorkoutData] = [
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
        WorkoutData(day: "Day 20", count: 1),
    ]

    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    VStack {
                        HStack {
                            Text("Workouts")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                                .padding(.top)
                            Spacer()
                        }
                        .padding(.horizontal)

                        WorkoutChartView(workoutData: workoutData)

                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    .blur(radius: isAdding ? 10 : 0)
                    .animation(.default, value: isAdding)

                    VStack {
                        HStack {
                            Text("Last Workouts")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                                .padding(.top)
                            Spacer()
                        }
                        .padding(.horizontal)

                        Spacer()

                        if isLoading {
                            ProgressView("Loading workouts...")
                        } else if let errorMessage = supabaseLogic.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        } else {
                            List {
                                ForEach(supabaseLogic.workouts, id: \.workout_id) { workout in
                                    WorkoutCellView(
                                        workout: workout,
                                        workoutExercises: supabaseLogic.workoutExercise,
                                        exercises: supabaseLogic.exercises
                                    )
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    .blur(radius: isAdding ? 10 : 0)
                    .animation(.default, value: isAdding)

                    HStack {
                        Spacer()

                        VStack {
                            if isAdding {
                                Button(action: {}) {
                                    Image(systemName: "fork.knife.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.purple)
                                }
                                .padding(.bottom, 10)

                                Button(action: {}) {
                                    Image(systemName: "trophy.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.purple)
                                }
                                .padding(.bottom, 10)
                            }

                            Button(action: {
                                withAnimation {
                                    self.isAdding.toggle()
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.purple)
                            }
                            .padding(.bottom, 30)
                        }
                        .padding(.trailing, 20)
                    }

                    HStack(spacing: 0) {
                        Button(action: {}) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 35))
                                Text("Home")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.purple)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                        }

                        Button(action: {}) {
                            VStack {
                                Image(systemName: "book.circle.fill")
                                    .font(.system(size: 35))
                                Text("Logs")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.purple)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                        }

                        Button(action: {}) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 35))
                                Text("Profile")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.purple)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .onAppear {
                Task {
                    await supabaseLogic.fetchWorkoutExercise()
                    await supabaseLogic.fetchWorkout()
                    await supabaseLogic.fetchExercise()
                    isLoading = false
                }
            }
        }
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
