//
//  Task_1App.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

@main
struct Task_1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StarterScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(SessionStore())
        }
    }
}
