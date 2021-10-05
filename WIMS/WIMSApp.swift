//
//  WIMSApp.swift
//  WIMS
//
//  Created by Thiago Medeiros on 05/10/21.
//

import SwiftUI

@main
struct WIMSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
