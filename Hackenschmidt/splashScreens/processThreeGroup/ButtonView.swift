//
//  ButtonView.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 04.06.2024.
//

import SwiftUI

struct ButtonView: View {
    let title: String
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
                    .frame(width: 340, height: 70, alignment: .center)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(selectedButton == tag ? Color("ButtonColor") : (showNextScreen ? Color.red : Color.black), lineWidth: 1)
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
