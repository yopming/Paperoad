//
//  PaperoadApp.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

@main
struct PaperoadApp: App {
    let persistenceController = PersistentController.shared
    
    @AppStorage("generalAppearnace") private var apperance = 0
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            SidebarCommands()
            
            // remove "New Window" option from menu File
            CommandGroup(replacing: .newItem, addition: {})
            
            // open library directory where sqlite file is located
            CommandMenu("Developer") {
                Button("Open Application Support") {
                    openApplicationSupportDir()
                }
            }
        }
        
        Settings {
            SettingsView()
        }
    }
}

private func openApplicationSupportDir() {
    let fileManager = FileManager.default
    let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
//    let dataDirectoryURL = appSupportURL.appendingPathComponent("data", isDirectory: true)
    let dataDirectoryURL = appSupportURL

    NSWorkspace.shared.open(dataDirectoryURL)
}
