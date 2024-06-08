//
//  AddMealForm.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import SwiftUI

struct AddMealForm: View {
    @State private var mealName: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack(alignment: .leading) {
                        Text("What is the Meal’s name?")
                            .foregroundStyle(Color("TextColor"))
                            .padding(.bottom, 20)
                        TextField("Name?", text: $mealName)
                            .frame(width: 313)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 50)
                    VStack(alignment: .leading) {
                        Text("Ingredients list")
                            .foregroundStyle(Color("TextColor"))
                            .padding(.bottom, 20)

                        NavigationLink(destination: AddExercise()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray.opacity(0.0))
                                    .frame(width: 340, height: 70)

                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black)
                                    .frame(width: 340, height: 70)

                                Text("Add a product")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("TextColor"))
                                    .frame(width: 340, height: 70, alignment: .center)
                            }
                        }
                        .frame(width: 340, height: 70)
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()

                    Button(action: {
                        
                    }) {
                        NavigationLink(
                            destination: AddExercise(),
                            label: {
                                Text("ADD")
                                    .frame(width: 340, height: 40)
                                    .foregroundColor(Color.white)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(5)
                            }
                        )
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddMealForm()
}
