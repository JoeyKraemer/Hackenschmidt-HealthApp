import SwiftUI

struct Homepage: View {
    @State private var isAdding: Bool = false

    var body: some View {
        NavigationView {
            TabView {
                ZStack {
                    Color("NormalBackground")
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        VStack {
                            HStack {
                                Text("Calories")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)
                                    .padding(.top)
                                Spacer()
                            }
                            .padding(.horizontal)
                            CalorieSlider(goal: 3000, food: 1750, burned: 700)

                            Spacer()
                        }
                        .frame(height: 340)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                        .blur(radius: isAdding ? 10 : 0)
                        .animation(.default, value: isAdding)

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
                                WorkoutData(day: "Day 20", count: 4),
                            ])
                            Spacer()
                        }
                        .frame(height: 280)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                        .blur(radius: isAdding ? 10 : 0)
                        .animation(.default, value: isAdding)

                        Spacer()
                    }
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .navigationBarHidden(true)

                    VStack {
                        Spacer()

                        HStack {
                            Spacer()
                            VStack {
                                if isAdding {
                                    NavigationLink(destination: AddMealView()) {
                                        Image(systemName: "fork.knife.circle.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.purple)
                                            .transition(.move(edge: .bottom))
                                            .animation(.easeInOut)
                                    }
                                    NavigationLink(destination: AddWorkoutView()) {
                                        Image(systemName: "trophy.circle.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.purple)
                                            .transition(.move(edge: .bottom))
                                            .animation(.easeInOut)
                                    }
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
                        }
                        .padding(.trailing, 20) // Adjust padding here as needed
                    }
                }
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.system(size: 45))
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

                AddMealView()
                    .tabItem {
                        VStack {
                            Image(systemName: "book.circle.fill")
                                .font(.system(size: 45))
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

                ProfileView()
                    .tabItem {
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
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Homepage()
}
