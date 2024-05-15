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

    @State private var showSecondSplash = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if !showSecondSplash {
                    ContentView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.showSecondSplash = true
                            }
                        }
                } else {
                    ProcessOne()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
