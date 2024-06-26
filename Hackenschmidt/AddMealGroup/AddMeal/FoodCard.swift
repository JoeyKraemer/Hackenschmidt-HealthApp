//
//  FoodCard.swift
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
                    .font(.system(size: 20, weight: .bold))
                    .bold()
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    VStack {
                        Text("\(calories)")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                        Text("cal")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                    }
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
