//
//  HackenschmidtApp.swift
//  Hackenschmidt
//
//  Created by paul on 29/04/2024.
//

import SwiftUI

@main
struct HackenschmidtApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authViewModel = AuthViewModel.shared
    @State private var isLoginCheckFinished = false

    @State private var showSecondSplash = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if !showSecondSplash {
                    ContentView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.authViewModel.checkLoginStatus {
                                    self.isLoginCheckFinished = true
                                    print("done")
                                }
                                self.showSecondSplash = true
                            }
                        }
                } else if !self.isLoginCheckFinished {
                    ZStack {
                        Color("BackgroundSplashSCreenColor").edgesIgnoringSafeArea(.all)
                        VStack {
                            ProgressView("Logging in...")
                                .tint(.black)
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                                .padding()
                        }
                    }
                } else {
                    if authViewModel.isLoggedIn {
                        Homepage()
                    } else {
                        ProcessOne()
                    }
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(authViewModel)
        }
    }
}
