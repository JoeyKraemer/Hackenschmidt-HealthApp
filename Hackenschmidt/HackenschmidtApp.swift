//
//  HackenschmidtApp.swift
//  Hackenschmidt
//
//  Created by paul on 29/04/2024.
//

import Supabase
import SwiftUI

@main
struct HackenschmidtApp: App {
    let persistenceController = PersistenceController.shared

//     supabase connection test
    let client = SupabaseClient(supabaseURL: URL(string: "https://ggelsjpzpdreuoxgaxid.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdnZWxzanB6cGRyZXVveGdheGlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ3MjgxMzcsImV4cCI6MjAzMDMwNDEzN30.X4BYTMMVwqSCExMOb-7UeqDciaQBmZxNfhiInR-S178")

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
                    //ProcessOne()
                    FoodFormCameraView()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
