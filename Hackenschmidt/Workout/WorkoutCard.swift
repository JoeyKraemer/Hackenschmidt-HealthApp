//
//  WorkoutCard.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//
//

import SwiftUI

struct WorkoutCard: View {
    var title: String
    var subtitle: String
    var exercises: Int

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
                        Text("\(exercises)")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                        Text("exercises")
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
