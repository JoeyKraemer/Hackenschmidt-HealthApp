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

    var body: some Scene {
        WindowGroup {
            ProcessTwo()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
