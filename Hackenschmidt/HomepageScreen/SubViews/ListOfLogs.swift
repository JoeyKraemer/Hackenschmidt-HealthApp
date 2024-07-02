//
//  ListOfLogs.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 24.06.2024.
//

import SwiftUI

struct ListOfLogs: View {
    @State private var supabasLogic = SupabaseLogic.shared
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Logs")
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 30, weight: .bold))
                            .padding(.top, 20)
                    }
                    VStack {
                        if isLoading {
                            ProgressView("Loading...")
                        } else if let errorMessage = supabasLogic.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        } else {
                            LazyVStack {
                                ScrollView {
                                    ForEach(supabasLogic.logs, id: \.log_id) { log in
                                        LogCard(date: log.log_date, log_id: log.log_id)
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            await supabasLogic.fetchLog()
                            isLoading = false
                        }
                    }
                }
            }
        }
    }
}
