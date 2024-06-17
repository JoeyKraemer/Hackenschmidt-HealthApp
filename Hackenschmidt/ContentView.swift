//
//  ContentView.swift
//  Hackenschmidt
//
//  Created by paul on 29/04/2024.
//

import CoreData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundSplashSCreenColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Hackenschmidt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 300)
                    Text("Hackenschmidt")
                        .foregroundStyle(Color("TextColorSplash"))
                        .font(.system(size: 35, weight: .bold))
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
