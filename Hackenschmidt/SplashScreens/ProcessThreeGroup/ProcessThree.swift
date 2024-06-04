//
//  ProcessThree.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 11.05.2024.
//

import SwiftUI

struct ProcessThree: View {
    @State private var calories: Int = 2000
    @State private var selectedButton: Int?
    @State private var selectedTitle: String = ""
    @State private var showNextScreen: Bool = false
    let buttonTitles = ["Lose Weight", "Maintain Weight", "Gain Weight", "Gain Muscles"]

    let processThreeChecker = ProcessThreeChecker()

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                    }
                    Spacer()
                    Spacer()
                    VStack {
                        Text("What is your goal")
                            .foregroundStyle(Color("TextColor"))
                        VStack(spacing: 20) {
                            ForEach(0 ..< 4, id: \.self) { index in
                                ButtonView(title: buttonTitles[index], tag: index, showNextScreen: processThreeChecker.checkGoal(goal: selectedTitle), selectedButton: $selectedButton)
                            }
                            .onReceive(selectedButton.publisher) { index in
                                selectedTitle = buttonTitles[index]
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    VStack {
                        Text("What is your calorie intake goal?")
                            .foregroundStyle(Color("TextColor"))

                        TextField("Enter your Caloris", text: Binding(
                            get: { "\(calories)" },
                            set: {
                                if let value = Int($0) {
                                    calories = value
                                }
                            }
                        ))
                        .frame(width: 313)
                        .padding()
                        .background(processThreeChecker.checkCalories(calories: calories) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Text("Cal")
                                    .padding(.trailing, 8)
                                    .foregroundColor(Color("TextColor"))
                            }
                        )
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {}) {
                        NavigationLink(
                            destination: AddWorkout(),
                            label: {
                                Text("Next")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                        .disabled(processThreeChecker.checkEmpty(selectedTitle: selectedTitle, calories: calories))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private func checkEmpty(selectedTitle: String, calories: Int) -> Bool {
    if selectedTitle.isEmpty || calories <= 0 {
        return true
    }

    return false
}

#Preview {
    ProcessThree()
}
