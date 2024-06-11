//
//  AddMealUI.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import SwiftUI

struct AddMealUI: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack() {
                    VStack {
                        SearchBar()
                    }

                    VStack() {
                        Text("My meals")
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 15, weight: .bold))
                    }

                    VStack {
                        FoodCard(title: "Title", subtitle: "hello very very big and big and text and it is very very big text yes it is big very", calories: 900)
                    }
                }
            }
        }
    }
}

#Preview {
    AddMealUI()
}
