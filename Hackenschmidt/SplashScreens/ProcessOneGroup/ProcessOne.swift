//
//  ProcessOne.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 01.05.2024.
//

import Foundation
import SwiftUI

struct ProcessOne: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var age = 0
    @State private var shouldNavigate = false

    let processOneChecker = ProcessOneChecker()
    let notificationHandler = NotificationHandler()

    @StateObject private var authViewModel = AuthViewModel.shared

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 80, height: 8)
                                    .foregroundStyle(Color("ProgressBarColor"))
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 80, height: 8)
                                    .foregroundStyle(Color.gray)
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 80, height: 8)
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                            Spacer()
                            VStack {
                                Text("Welcome")
                                    .foregroundStyle(Color("ButtonColor"))
                                    .font(.system(size: 30, weight: .bold))
                                Text("Let's Start!")
                                    .foregroundStyle(Color("TextColor"))
                            }
                            Spacer()

                            VStack {
                                Text("What should we call you?")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Enter your name", text: $userName)
                                    .frame(width: 313)
                                    .padding()
                                    .background(processOneChecker.checkUsername(username: userName) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                                    .cornerRadius(10)

                                Text("What is your age")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Enter your age", text: Binding(
                                    get: { "\(age)" },
                                    set: {
                                        if let value = Int($0) {
                                            age = value
                                            CalorieCalculator.shared.setAge(age: age)
                                        }
                                    }
                                ))
                                .frame(width: 313)
                                .padding()
                                .background(processOneChecker.checkAge(age: age) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                                .cornerRadius(10)

                                Text("What is your email?")
                                    .foregroundStyle(Color("TextColor"))
                                TextField("Enter your email", text: $email)
                                    .frame(width: 313)
                                    .padding()
                                    .background(processOneChecker.checkEmail(email: email) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                                    .cornerRadius(10)

                                Text("Come up with the password")
                                    .foregroundStyle(Color("TextColor"))
                                SecureField("Enter your password", text: $password)
                                    .frame(width: 313)
                                    .padding()
                                    .background(processOneChecker.checkPassword(password: password) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                            }
                            Spacer()
                            VStack {
                                Text("Already have an account?")
                                    .foregroundColor(Color("TextColor"))
                                NavigationLink(
                                    destination: LogInUI(),
                                    label: {
                                        Text("Log in")
                                            .foregroundColor(Color("ButtonColor"))
                                    }
                                )
                            }
                            .padding(.top, 20)
                            Spacer()
                            Spacer()
                            Spacer()
                            Button(action: {
                                Task {
                                    if !processOneChecker.checkAll(username: userName, email: email, password: password, age: age) {
                                        UserProfileInformationGather.shared.setName(name: userName)
                                        UserProfileInformationGather.shared.setAge(age: age)
                                        shouldNavigate = true
                                    }
                                }
                            }) {
                                Text("Next")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(processOneChecker.checkAll(username: userName, email: email, password: password, age: age) ? Color.gray : Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                            .disabled(processOneChecker.checkAll(username: userName, email: email, password: password, age: age))

                            NavigationLink(
                                destination: ProcessTwo(),
                                isActive: $shouldNavigate,
                                label: {
                                    EmptyView()
                                }
                            )
                            .hidden()
                        }
                        .padding()
                        .background(Color("NormalBackground"))
                        .cornerRadius(10)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    }
                    .frame(minHeight: geometry.size.height)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
        }
    }
}

#Preview {
    ProcessOne().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
