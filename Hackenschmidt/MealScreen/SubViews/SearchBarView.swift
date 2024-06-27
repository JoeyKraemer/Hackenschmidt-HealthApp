//
//  SearchBarView.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 09.06.2024.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color("NormalBackground"))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}
