//
//  AddMealUI.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import SwiftUI

struct AddMealUI: View {
    @StateObject private var supabasLogic = SupabaseLogic()
    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        SearchBar()
                    }

                    VStack {
                        Text("My meals")
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 15, weight: .bold))
                    }

                    VStack {
                        if supabasLogic.isLoading {
                            ProgressView("Loading...")
                        } else if let errorMessage = supabasLogic.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        } else {
                            List(supabasLogic.foods, id: \.self) { food in
                                FoodCard(title: food.food_name, subtitle: food.additional, calories: Int(food.calories))
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            await supabasLogic.fetchFoods()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddMealUI()
}
