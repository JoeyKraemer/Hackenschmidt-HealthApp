//
//  ProcessThree.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 11.05.2024.
//

import SwiftUI

struct ProcessThree: View {
    @State private var calories: Int = 0
    @State private var selectedButton: Int?
    @State private var selectedTitle: String = ""
    @State private var showNextScreen: Bool = false
    @State private var shouldNavigate = false
    
    let buttonTitles = ["Lose Weight", "Maintain Weight", "Grow Muscles"]

    let processThreeChecker = ProcessThreeChecker()
    let userInfo = UserProfileInformationGather.shared.getAllInformation()
    
    @StateObject private var supabaseLogic = SupabaseLogic()
    @StateObject private var authViewModel = AuthViewModel.shared

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
                            ForEach(0 ..< 3, id: \.self) { index in
                                ButtonView(title: buttonTitles[index], tag: index, showNextScreen: processThreeChecker.checkGoal(goal: selectedTitle), selectedButton: $selectedButton)
                            }
                            .onReceive(selectedButton.publisher) { index in
                                selectedTitle = buttonTitles[index]
                                CalorieCalculator.shared.setGoal(goal: selectedTitle)
                                calories = CalorieCalculator.shared.getTotalCalories()
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    VStack {
                        Text("This is your calorie intake goal")
                            .foregroundStyle(Color("TextColor"))

                        Text(calories == 0 ? "Please Set The Goal" : "\(calories)")
                            .frame(width: 313)
                            .padding()
                            .background(Color.gray.opacity(0.1))
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
                    Button(action: {
                        if !processThreeChecker.checkEmpty(selectedTitle: selectedTitle, calories: calories) {
                            Task{
                                await supabaseLogic.appendUserProfile(user_id: authViewModel.uid!, name: userInfo.name, calorie_goal: calories, weight: userInfo.weight, height: userInfo.height, sex: userInfo.sex, activity: userInfo.activity, body_goal: selectedTitle, age: userInfo.age)
                                shouldNavigate = true
                            }
                        }
                    }) {
                        Text("Next")
                            .frame(width: 340, height: 40)
                            .foregroundColor(Color.white)
                            .background(processThreeChecker.checkEmpty(selectedTitle: selectedTitle, calories: calories) ? Color.gray : Color("ButtonColor"))
                            .cornerRadius(5)
                    }
                    .disabled(processThreeChecker.checkEmpty(selectedTitle: selectedTitle, calories: calories))

                    NavigationLink(
                        destination: Homepage(),
                        isActive: $shouldNavigate,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
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
