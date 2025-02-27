//
//  Tubes_MotionApp.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import SwiftUI

@main
struct Tubes_MotionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
