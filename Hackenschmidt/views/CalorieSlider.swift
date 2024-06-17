//
//  CalorieSlider.swift
//  Hackenschmidt
//
//  Created by paul on 03/06/2024.
//

import SwiftUI

struct CalorieSlider: View {
    let goal: Double
    let food: Double
    let burned: Double

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
                .frame(width: 150, height: 150)
                .padding()

                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("Goal")
                            .font(.system(size: 18, weight: .regular, design: .default))
                        Text("\(Int(goal))")
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
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding()
    }
}

#Preview {
    CalorieSlider(goal: 3000, food: 1750, burned: 700)
}
