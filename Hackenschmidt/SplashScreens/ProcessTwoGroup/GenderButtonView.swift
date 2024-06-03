////
////  GenderButtonView.swift
////  Hackenschmidt
////
////  Created by Богдан Закусило on 03.06.2024.
////
//
//import SwiftUI
//
//struct GenderButtonView: View {
//    let gender: String
//    let tag: Int
//    @Binding var selectedButton: Int?
//    
//    Button(action: {
//        self.selectedButton = self.tag
//    }) {
//        ZStack {
//            RoundedRectangle(cornerRadius: 6)
//                .fill(isClickedMale ? Color("ButtonColor").opacity(0.5) : Color.gray.opacity(0.0))
//                .frame(width: 140, height: 50)
//
//            RoundedRectangle(cornerRadius: 6)
//                .stroke(showNextScreen ? Color.red : Color.black, lineWidth: 1)
//                .frame(width: 140, height: 50)
//
//            Text("Male")
//                .foregroundColor(Color("TextColor"))
//        }
//    }
//}
//
//#Preview {
//    GenderButtonView()
//}
