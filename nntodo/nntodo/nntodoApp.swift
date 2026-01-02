//
//  nntodoApp.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import SwiftUI
import CoreData

@main
struct nntodoApp: App {
    @StateObject private var themeManager = ThemeManager()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
