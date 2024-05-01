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
    @State private var isClicked = false

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
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color.gray)
                    }
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
                    VStack {
                        Text("Please select which sex we should use to calculate your calorie need:")
                            .foregroundStyle(Color("TextColor"))
                            .padding()
                        HStack {
                            Button(action: {
                                isClicked.toggle() // Toggle the state
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(isClicked ? Color.blue.opacity(0.5) : Color.gray.opacity(0.0))
                                        .frame(width: 100, height: 10)

                                    Text("Male")
                                        .foregroundColor(.white)
                                        .opacity(isClicked ? 1.0 : 0.5)
                                }
                            }
                            .padding()
                            Button(action: {
                                isClicked.toggle() // Toggle the state
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(isClicked ? Color.blue.opacity(0.5) : Color.gray.opacity(0.0))
                                        .frame(width: 100, height: 10)
                                    
                                    Text("Female")
                                        .foregroundColor(.white)
                                        .opacity(isClicked ? 1.0 : 0.5)
                                }
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ProcessTwo()
}
