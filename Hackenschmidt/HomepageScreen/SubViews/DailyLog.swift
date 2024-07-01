//
//  DailyLog.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//
import SwiftUI

struct DailyLog: View {
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {
                    // Previous day action
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                VStack {
                    Text("Day 20")
                        .font(.headline)
                    Text("Today - 25/04/2024")
                        .font(.subheadline)
                }
                Spacer()
                Button(action: {
                    // Next day action
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()

            // Calories Circular Progress
            VStack {
                Text("Calories")
                    .font(.headline)
                CircularProgressView(remaining: 1150, goal: 2000, food: 1350, burned: 500)
                    .frame(width: 150, height: 150)
            }
            .padding()

            // Meal List
            VStack(alignment: .leading) {
                Text("Meal list")
                    .font(.headline)
                    .padding(.bottom, 5)
                MealItemView(name: "Fruit Bowl", details: "1 apple, 1 banana, 1 cup...", calories: 900)
                MealItemView(name: "Pasta", details: "80g pasta, 10 cherry to...", calories: 450)
            }
            .padding()

            // Workout List
            VStack(alignment: .leading) {
                Text("Workout list")
                    .font(.headline)
                    .padding(.bottom, 5)
                WorkoutItemView(name: "Cardio", details: "30m running, 20m walki...", calories: 250)
                WorkoutItemView(name: "Push", details: "3x 20 push-ups, 3x 20 fl...", calories: 250)
            }
            .padding()

            Spacer()

            // Add button
            Button(action: {
                // Add action
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.purple)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}

struct CircularProgressView: View {
    var remaining: Int
    var goal: Int
    var food: Int
    var burned: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(Double(remaining) / Double(goal), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.purple)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: remaining)

            VStack {
                Text("\(remaining)")
                    .font(.largeTitle)
                Text("Remaining")
                    .font(.subheadline)
            }
        }
    }
}

struct MealItemView: View {
    var name: String
    var details: String
    var calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(details)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
            Text("\(calories) cal")
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct WorkoutItemView: View {
    var name: String
    var details: String
    var calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(details)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
            Text("\(calories) cal")
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
