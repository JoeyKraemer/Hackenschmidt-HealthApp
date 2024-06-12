//
//  LogInUI.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 12.06.2024.
//

import SwiftUI

struct LogInUI: View {
    @State private var email: String = ""
    @State private var password: String = ""

    let logInChecker = LogInChecker()
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
                    }
                    .padding(.bottom, 20)

                    VStack {
                        Text("What is your email?")
                            .foregroundStyle(Color("TextColor"))
                        TextField("Enter your email", text: $email)
                            .frame(width: 313)
                            .padding()
                            .background(logInChecker.checkEmail(email: email) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                            .cornerRadius(10)

                        Text("What is your password")
                            .foregroundStyle(Color("TextColor"))
                        SecureField("Enter your password", text: $password)
                            .frame(width: 313)
                            .padding()
                            .background(logInChecker.checkPassword(password: password) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {}) {
                        NavigationLink(
                            destination: LogInUI(),
                            label: {
                                Text("Log In")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(logInChecker.checkAll(password: password, email: email) ? Color.gray : Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                        .disabled(logInChecker.checkAll(password: password, email: email))
                    }
                }
            }
        }
    }
}

#Preview {
    LogInUI()
}
