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
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    NavigationLink(destination: ProcessTwo()) {
                        Text("Next")
                            .frame(width: 290, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
}

#Preview {
    ProcessOne().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
