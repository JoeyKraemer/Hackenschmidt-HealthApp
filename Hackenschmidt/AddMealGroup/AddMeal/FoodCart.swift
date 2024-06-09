//
//  FoodCart.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 09.06.2024.
//

import SwiftUI

struct FoodCard: View {
    var title: String
    var subtitle: String
    var calories: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .bold()
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            VStack(){
                ZStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 50, height: 50)
                    Text("\(calories) cal")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding()
        .background(Color("NormalBackground"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
