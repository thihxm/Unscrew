//
//  WIMSApp.swift
//  WIMS
//
//  Created by Thiago Medeiros on 05/10/21.
//

import SwiftUI

@main
struct UnscrewApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            HomeProjectsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                persistenceController.save()
            }
        }
    }
}
