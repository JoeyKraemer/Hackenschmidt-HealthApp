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
    @State private var selectedActivity: String = ""
    @State private var weight: Int = 0
    @State private var height: Int = 0
    @State private var gender: String = ""
    @State private var activity: String = ""
    @State private var isClickedMale = false
    @State private var isClickedFemale = false
    @State private var showNextScreen: Bool = false

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
                        .background(Color.gray.opacity(0.1))
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
                        TextField("Enter your Weight", text: Binding(
                            get: { "\(height)" },
                            set: {
                                if let value = Int($0) {
                                    height = value
                                }
                            }
                        ))
                        .frame(width: 313)
                        .padding()
                        .background(Color.gray.opacity(0.1))
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
                                        .stroke(Color.black, lineWidth: 1)
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
                                        .stroke(Color.black, lineWidth: 1)
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
                        Text(activity)
                        ForEach(0 ..< 3, id: \.self) { index in
                            Button(action: {
                                selectedButton = index
                                activity = activityTitles[index]
                            }) {
                                ActivityButtonView(activity: activityTitles[index], text: textTitles[index], tag: index, selectedButton: $selectedButton, selectedActivity: $selectedActivity)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {
                        showNextScreen = checkForNil(weight: weight, height: height, gender: gender, activity: activity)
                    }) {
                        NavigationLink(
                            destination: ProcessTwo(),
                            label: {
                                Text("Next")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                        .disabled(checkForNil(weight: weight, height: height, gender: gender, activity: activity))
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private func checkForNil(weight: Int, height: Int, gender: String, activity: String) -> Bool{
    if weight <= 0 {
        print(weight)
        return true
    }
    if height <= 0 {
        print(height)
        return true
    }
    if gender.isEmpty {
        print(gender)
        return true
    }
    if activity.isEmpty {
        print(activity)
        return true
    }
    
    return false
}


struct ActivityButtonView: View{
    let activity: String
    let text: String
    let tag: Int
    @Binding var selectedButton: Int?
    @Binding var selectedActivity: String
    
    var body: some View {
        Button(action: {
            self.selectedButton = self.tag
            self.selectedActivity = self.activity
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.0))
                    .frame(width: 340, height: 70)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(selectedButton == tag ? Color("ButtonColor") : Color.black, lineWidth: 1)
                    .frame(width: 340, height: 70)

                VStack(alignment: .leading) {
                    Text(activity)
                        .font(.system(size: 20))
                        .foregroundColor(selectedButton == tag ? Color("ButtonColor") : Color("TextColor"))
                        .padding(.horizontal, 11)
                        .padding(.top, 10)

                    Text(text)
                        .font(.system(size: 10))
                        .foregroundColor(selectedButton == tag ? Color("TextColor") : Color("GrayText"))
                        .padding(.horizontal, 11)
                        .padding(.bottom, 10)
                }
                .frame(width: 340, height: 70, alignment: .leading)
            }
        }
    }
}

#Preview {
    ProcessTwo()
}
