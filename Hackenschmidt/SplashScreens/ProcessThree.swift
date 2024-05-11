//
//  ProcessThree.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 11.05.2024.
//

import SwiftUI

struct ProcessThree: View {
    @State private var calories:Int = 2000
    @State private var selectedButton: Int?
    let buttonTitles = ["Loose Weight", "Maintain Weight", "Gain Weight", "Gain Muscles"]
    
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
                    VStack(){
                        Text("What is your goal")
                            .foregroundStyle(Color("TextColor"))
                        VStack(spacing: 20) {
                            ForEach(0..<4, id: \.self) { index in
                                ButtonView(title: buttonTitles[index], tag: index, selectedButton: $selectedButton)
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    VStack(){
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
                    NavigationLink(destination: ProcessThree()) {
                        Text("Next")
                            .frame(width: 340, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(5)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ButtonView: View {
    let title: String
    let tag: Int
    @Binding var selectedButton: Int?

    var body: some View {
        Button(action: {
            self.selectedButton = self.tag
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.0))
                    .frame(width: 340, height: 70, alignment: .center)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(selectedButton == tag ? Color("ButtonColor") : Color.black, lineWidth: 1)
                    .frame(width: 340, height: 70, alignment: .center)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 20))
                            .foregroundColor(selectedButton == tag ? Color("ButtonColor") : Color("TextColor"))
                        .padding(.horizontal, 11)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .frame(width: 340, height: 70, alignment: .leading)
            }
        }
        
    }
}

#Preview {
    ProcessThree()
}
