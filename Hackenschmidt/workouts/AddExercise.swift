//
//  AddExercise.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 22.05.2024.
//

import SwiftUI

struct AddExercise: View {
    @State private var name: String = ""
    @State private var sets: Int = 0
    @State private var weight: Int = 0
    @State private var muscleGroup = ""
    @State private var isDropdownOpen = false
    @State private var selectedEquipment = "Select equipment"
    @State private var selectedButton: Int?
    
    let equipmentOptions = ["Treadmill", "Dumbbells", "Stationary Bike", "Elliptical"]
    let muscles = ["Shoulders", "Back", "Chest", "Legs"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)
                
                VStack(){
                    VStack {
                        Text("What is the exercise name?")
                            .foregroundStyle(Color("TextColor"))
                        TextField("Name", text: $name)
                            .frame(width: 313)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    VStack {
                        Text("How many sets did you do?")
                            .foregroundStyle(Color("TextColor"))
                        TextField("Enter your Weight", text: Binding(
                            get: { "\(sets)" },
                            set: {
                                if let value = Int($0) {
                                    sets = value
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
                                Text("Amount")
                                    .padding(.trailing, 8)
                                    .foregroundColor(Color("TextColor"))
                            }
                        )
                    }
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                self.isDropdownOpen.toggle()
                            }
                        }) {
                            HStack {
                                Text(selectedEquipment)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.purple)
                                    .rotationEffect(.degrees(isDropdownOpen ? 180 : 0))
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .frame(width: 340)

                        if isDropdownOpen {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(equipmentOptions, id: \.self) { option in
                                    Button(action: {
                                        self.selectedEquipment = option
                                        withAnimation {
                                            self.isDropdownOpen = false
                                        }
                                    }) {
                                        Text(option)
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.gray), alignment: .bottom
                                    )
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    VStack {
                        Text("How much weight did you use?")
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
                    .padding(.bottom, 15)
                    
                    VStack(){
                        Text("What muscle group does it use?")
                            .foregroundStyle(Color("TextColor"))
                        
                        ForEach(0 ..< 4, id: \.self) { index in
                            ExerciseButtonView(muscle: muscles[index], tag: index, selectedButton: $selectedButton)
                        }
                        .onReceive(selectedButton.publisher) { index in
                            muscleGroup = muscles[index]
                        }
                    }
                    Spacer()
                    Button(action: {
                        print("hello")
                    }) {
                        NavigationLink(
                            destination: AddWorkout(),
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

struct ExerciseButtonView: View {
    let muscle: String
    let tag: Int
    @Binding var selectedButton: Int?

    var body: some View {
        Button(action: {
            self.selectedButton = self.tag
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.0))
                    .frame(width: 340, height: 55)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(selectedButton == tag ? Color("ButtonColor") : Color.black)
                    .frame(width: 340, height: 55)

                Text(muscle)
                    .font(.system(size: 20))
                    .foregroundColor(selectedButton == tag ? Color("ButtonColor") : Color("TextColor"))
                    .frame(width: 340, height: 40, alignment: .center)
            }
        }
    }
}




#Preview {
    AddExercise()
}
