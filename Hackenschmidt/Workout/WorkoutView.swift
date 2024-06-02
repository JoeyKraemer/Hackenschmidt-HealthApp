//
//  WorkoutView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 28.05.24.
//
import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context _: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_: UIVisualEffectView, context _: Context) {}
}

struct WorkoutView: View {
    @State private var isAdding: Bool = false
    
    var workouts: [Workout] = [
        Workout(exercise: "Bench Press", sets: [(0, 20), (20, 8), (20, 8), (20, 8)]),
        Workout(exercise: "Barbell row", sets: [(20, 8), (20, 8), (20, 8), (20, 8)]),
        Workout(exercise: "Dumbbell Shoulder Press", sets: [(10, 8), (10, 8), (10, 8), (10, 8)]),
        Workout(exercise: "Inclined Machine Chest Press", sets: [(40, 8), (40, 8), (40, 8), (40, 8)]),
    ]
    
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
        WorkoutData(day: "Day 20", count: 4),
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
                        
                        // Integrate WorkoutChartView
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
                        
                        List(workouts) { workout in
                            WorkoutCellView(workout: workout)
                        }
                        .frame(minHeight: 750)
                        .listStyle(PlainListStyle())
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    .blur(radius: isAdding ? 10 : 0)
                    .animation(.default, value: isAdding)
                    
                    // Plus icon menu
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
                    
                    // Menu bar
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
        }
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
