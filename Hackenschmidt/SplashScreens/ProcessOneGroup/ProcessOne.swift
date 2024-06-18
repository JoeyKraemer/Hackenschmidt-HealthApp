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

    let processOneChecker = ProcessOneChecker()
    let notificationHandler = NotificationHandler()

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color("ProgressBarColor"))
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 80, height: 8)
                            .foregroundStyle(Color.gray)
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
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
                        notificationHandler.askPermission()
                    }) {
                        NavigationLink(
                            destination: ProcessTwo(),
                            label: {
                                Text("Next")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(processOneChecker.checkAll(username: userName, email: email, password: password) ? Color.gray : Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                        .disabled(processOneChecker.checkAll(username: userName, email: email, password: password))
                    }
                }
            }
        }
    }
}

#Preview {
    ProcessOne().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
