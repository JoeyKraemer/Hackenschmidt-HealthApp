//
//  ProcessTwo.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 01.05.2024.
//

import SwiftUI

struct ProcessTwo: View {
    let activityTitles = ["Very Active", "Active", "Not Very Active"]
    let textTitles = ["Spend most of the day doing heavy physical activity (e.g. food server, carpenter)", "Spend most of the day doing some physical activity (e.g. teacher, sales person)", "Spend most of the day sitting (e.g. desk job, bank teller)"]

    @State private var selectedButton: Int?
    @State private var weight: Int = 0
    @State private var height: Int = 0
    @State private var gender: String = ""
    @State private var activity: String = ""
    @State private var isClickedMale = false
    @State private var isClickedFemale = false
    @State private var showNextScreen: Bool = true

    @ObservedObject var processTwoChecker = ProcessTwoChecker()

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color.gray)
                    }
                    Spacer()
                    Spacer()
                    VStack {
                        Text("How much do you weight")
                            .foregroundStyle(Color("TextColor"))
                        TextField("Enter your Weight", text: Binding(
                            get: { "\(weight)" },
                            set: {
                                if let value = Int($0) {
                                    weight = value
                                }
                            }
                        ))
                        .frame(width: 313)
                        .padding()
                        .background(processTwoChecker.isWeightEmpty(weight: weight) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Text("kg")
                                    .padding(.trailing, 8)
                                    .foregroundColor(Color("TextColor"))
                            }
                        )
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack {
                        Text("How tall are you")
                            .foregroundStyle(Color("TextColor"))
                        TextField("Enter your Height", text: Binding(
                            get: { "\(height)" },
                            set: {
                                if let value = Int($0) {
                                    height = value
                                }
                            }
                        ))
                        .frame(width: 313)
                        .padding()
                        .background(processTwoChecker.isHeightEmpty(height: height) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Text("cm")
                                    .padding(.trailing, 8)
                                    .foregroundColor(Color("TextColor"))
                            }
                        )
                    }
                    Spacer()
                    Spacer()
                    VStack {
                        Text("Please select which sex we should use to calculate your calorie need:")
                            .foregroundStyle(Color("TextColor"))

                        HStack {
                            Spacer()
                            Button(action: {
                                isClickedMale = true
                                isClickedFemale = false
                                gender = "Male"
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(isClickedMale ? Color("ButtonColor").opacity(0.5) : Color.gray.opacity(0.0))
                                        .frame(width: 140, height: 50)

                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(processTwoChecker.isGenderEmpty(gender: gender) ? Color.red : Color.black, lineWidth: 1)
                                        .frame(width: 140, height: 50)

                                    Text("Male")
                                        .foregroundColor(Color("TextColor"))
                                }
                            }
                            .padding()
                            Spacer()
                            Button(action: {
                                isClickedFemale = true
                                isClickedMale = false
                                gender = "Female"
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(isClickedFemale ? Color("ButtonColor").opacity(0.5) : Color.gray.opacity(0.0))
                                        .frame(width: 140, height: 50)

                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(processTwoChecker.isGenderEmpty(gender: gender) ? Color.red : Color.black, lineWidth: 1)
                                        .frame(width: 140, height: 50)

                                    Text("Female")
                                        .foregroundColor(Color("TextColor"))
                                }
                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack(spacing: 10) {
                        Text("What is your activity level?")
                            .foregroundColor(Color("TextColor"))
                            .padding()
                        ForEach(0 ..< 3, id: \.self) { index in
                            ActivityButtonView(activity: activityTitles[index], text: textTitles[index], tag: index, showNextScreen: processTwoChecker.isActivityEmpty(activity: activity), selectedButton: $selectedButton)
                        }
                        .onReceive(selectedButton.publisher) { index in
                            activity = activityTitles[index]
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {}) {
                        NavigationLink(
                            destination: ProcessThree(),
                            label: {
                                Text("Next")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(processTwoChecker.checkForNil(weight: weight, height: height, gender: gender, activity: activity) ? Color.gray : Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                        .disabled(processTwoChecker.checkForNil(weight: weight, height: height, gender: gender, activity: activity))
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProcessTwo()
}
