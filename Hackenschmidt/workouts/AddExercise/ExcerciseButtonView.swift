//
//  ExcerciseButtonView.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import SwiftUI

struct ExerciseButtonView: View {
    let muscle: String
    let tag: Int
    let showNextScreen: Bool
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
                    .stroke(selectedButton == tag ? Color("ButtonColor") : (showNextScreen ? Color.red : Color.black), lineWidth: 1)
                    .frame(width: 340, height: 55)

                Text(muscle)
                    .font(.system(size: 20))
                    .foregroundColor(selectedButton == tag ? Color("ButtonColor") : Color("TextColor"))
                    .frame(width: 340, height: 40, alignment: .center)
            }
        }
    }
}
