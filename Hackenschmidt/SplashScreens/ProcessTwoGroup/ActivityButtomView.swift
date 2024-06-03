//
//  ActivityButtomView.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 03.06.2024.
//

import SwiftUI

struct ActivityButtonView: View {
    let activity: String
    let text: String
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
                    .frame(width: 340, height: 70)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(selectedButton == tag ? Color("ButtonColor") : (showNextScreen ? Color.red : Color.black), lineWidth: 1)
                    .frame(width: 340, height: 70)

                VStack(alignment: .leading) {
                    Text(activity)
                        .font(.system(size: 20))
                        .foregroundColor(selectedButton == tag ? Color("ButtonColor") : Color("TextColor"))
                        .padding(.horizontal, 11)
                        .padding(.top, 10)

                    Text(text)
                        .font(.system(size: 10))
                        .foregroundColor(selectedButton == tag ? Color("TextColor") : Color("GrayText"))
                        .padding(.horizontal, 11)
                        .padding(.bottom, 10)
                }
                .frame(width: 340, height: 70, alignment: .leading)
            }
        }
    }
}
