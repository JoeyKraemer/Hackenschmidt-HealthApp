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
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct WorkoutView: View {
    @State private var isAdding: Bool = false
    
    var workouts: [Workout] = [
        Workout(exercise: "Bench Press", sets: [(0, 20), (20, 8), (20, 8), (20, 8)]),
        Workout(exercise: "Barbell row", sets: [(20, 8), (20, 8), (20, 8), (20, 8)]),
        Workout(exercise: "Dumbbell Shoulder Press", sets: [(10, 8), (10, 8), (10, 8), (10, 8)]),
        Workout(exercise: "Inclined Machine Chest Press", sets: [(40, 8), (40, 8), (40, 8), (40, 8)])
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemPurple).opacity(0.1).edgesIgnoringSafeArea(.all)
            
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
                    
                    Spacer()
                }
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
                .blur(radius: isAdding ? 10 : 0)
                .animation(.default, value: isAdding)
                
                // Workout list integration
                List(workouts) { workout in
                    WorkoutCellView(workout: workout)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
                .blur(radius: isAdding ? 10 : 0)
                .animation(.default, value: isAdding)
                
                Spacer()
                
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

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
