//
//  LogCard.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 24.06.2024.
//

import SwiftUI

struct LogCard: View {
    var date: String
    var log_id: Int
    var body: some View {
        NavigationLink(destination: DailyLog(log_id: log_id, date: date)) {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(date == "" ? Color.purple : Color.gray, lineWidth: 1)
                    .frame(width: 350, height: 100)
                    .background(Color.purple.opacity(0.1))
                VStack(spacing: 10) {
                    Text("Day 20")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(date)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .padding()
                .cornerRadius(10)
            }
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}
