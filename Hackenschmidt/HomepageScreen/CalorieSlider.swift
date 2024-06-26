//
//  CalorieSlider.swift
//  Hackenschmidt
//
//  Created by paul on 03/06/2024.
//

import SwiftUI

struct CalorieSlider: View {
    @State var goal: Double = 0
    var food: Double
    var burned: Double
    @StateObject private var supabasLogic = SupabaseLogic()

    var remaining: Double {
        goal - food + burned
    }

    var progress: Double {
        (goal - remaining) / goal
    }

    var body: some View {
        VStack {
            HStack {
                Text("Remaining = Goal - Food + Exercise")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            if supabasLogic.user_loading {
                ProgressView("Loading...")
            } else if let errorMessage = supabasLogic.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
                HStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(Color.purple)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.purple)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear, value: progress)

                        VStack {
                            Text("\(Int(remaining))")
                                .font(.system(size: 20, weight: .bold, design: .default))
                            Text("Remaining")
                                .font(.system(size: 14, weight: .thin, design: .default))
                        }
                    }
                    .frame(width: 125, height: 125)
                    .padding()

                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Goal")
                                .font(.system(size: 18, weight: .regular, design: .default))
                            Text("\(Int(supabasLogic.user_profiles[0].calorie_goal))")
                        }
                        VStack(alignment: .leading) {
                            Text("Food")
                                .font(.system(size: 18, weight: .regular, design: .default))
                            Text("\(Int(food))")
                        }
                        VStack(alignment: .leading) {
                            Text("Burned")
                                .font(.system(size: 18, weight: .regular, design: .default))
                            Text("\(Int(burned))")
                        }
                    }
                    .padding()
                    .font(.headline)
                    .onAppear {
                        goal = Double(supabasLogic.user_profiles[0].calorie_goal)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .padding()
        .onAppear {
            Task {
                await supabasLogic.fetchUserProfile()
            }
        }
    }
}

#Preview {
    CalorieSlider(goal: 3000, food: 1750, burned: 700)
}
