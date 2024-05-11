//
//  ProcessTwo.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 01.05.2024.
//

import SwiftUI

struct ProcessTwo: View {
    @State private var weight: Int = 0
    @State private var height: Int = 0
    @State private var gender: String = ""
    @State private var activity: String = ""
    @State private var isClickedMale = false
    @State private var isClickedFemale = false
    @State private var isClickedActive = false
    @State private var isClickedVeryActive = false
    @State private var isClickedNotVeryActive = false

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

                        Button(action: {
                            isClickedActive = false
                            isClickedVeryActive = true
                            isClickedNotVeryActive = false
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray.opacity(0.0))
                                    .frame(width: 340, height: 70, alignment: .center)

                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(isClickedVeryActive ? Color("ButtonColor") : Color.black, lineWidth: 1)
                                    .frame(width: 340, height: 70, alignment: .center)

                                VStack(alignment: .leading) {
                                    Text("Very Active")
                                        .font(.system(size: 20))
                                        .foregroundColor(isClickedVeryActive ? Color("ButtonColor") : Color("TextColor"))
                                        .padding(.horizontal, 11)

                                    Text("Spend most of the day doing heavy physical activity (e.g. food server, carpenter)")
                                        .font(.system(size: 10))
                                        .foregroundColor(isClickedVeryActive ? Color("TextColor") : Color("GrayText"))
                                        .padding(.horizontal, 11)
                                }
                                .frame(width: 340, height: 70, alignment: .leading)
                            }
                        }

                        Button(action: {
                            isClickedActive = true
                            isClickedVeryActive = false
                            isClickedNotVeryActive = false
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray.opacity(0.0))
                                    .frame(width: 340, height: 70)

                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(isClickedActive ? Color("ButtonColor") : Color.black, lineWidth: 1)
                                    .frame(width: 340, height: 70)

                                VStack(alignment: .leading) {
                                    Text("Active")
                                        .font(.system(size: 20))
                                        .foregroundColor(isClickedActive ? Color("ButtonColor") : Color("TextColor"))
                                        .padding(.horizontal, 11)

                                    Text("Spend most of the day doing some physical activity (e.g. teacher, sales person)")
                                        .font(.system(size: 10))
                                        .foregroundColor(isClickedActive ? Color("TextColor") : Color("GrayText"))
                                        .padding(.horizontal, 11)
                                }
                                .frame(width: 340, height: 70, alignment: .leading)
                            }
                        }

                        Button(action: {
                            isClickedActive = false
                            isClickedVeryActive = false
                            isClickedNotVeryActive = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray.opacity(0.0))
                                    .frame(width: 340, height: 70)

                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(isClickedNotVeryActive ? Color("ButtonColor") : Color.black, lineWidth: 1)
                                    .frame(width: 340, height: 70)

                                VStack(alignment: .leading) {
                                    Text("Not Very Active")
                                        .font(.system(size: 20))
                                        .foregroundColor(isClickedNotVeryActive ? Color("ButtonColor") : Color("TextColor"))
                                        .padding(.horizontal, 11)
                                        .padding(.top, 10)

                                    Text("Spend most of the day sitting (e.g. desk job, bank teller)")
                                        .font(.system(size: 10))
                                        .foregroundColor(isClickedNotVeryActive ? Color("TextColor") : Color("GrayText"))
                                        .padding(.horizontal, 11)
                                        .padding(.bottom, 10)
                                }
                                .frame(width: 340, height: 70, alignment: .leading)
                            }
                        }

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Spacer()
                    Spacer()
                    NavigationLink(destination: ProcessThree()) {
                        Text("Next")
                            .frame(width: 340, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(5)
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
