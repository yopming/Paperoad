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
    
    // global dark mode or light mode
    @AppStorage("prefColorScheme") private var theme = "Follow System"
    
    static let documentDirectory: URL = {
        let availableDirectories = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
        
        return availableDirectories[0]
            .appendingPathComponent("Paperoad")
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(theme == "Dark"
                                      ? .dark
                                      : (theme == "Light" ? .light : nil))
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
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
                .preferredColorScheme(theme == "Dark"
                                      ? .dark
                                      : (theme == "Light" ? .light : nil))
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

private func openApplicationSupportDir() {
    let fileManager = FileManager.default
    let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
//    let dataDirectoryURL = appSupportURL.appendingPathComponent("data", isDirectory: true)
    let dataDirectoryURL = appSupportURL

    NSWorkspace.shared.open(dataDirectoryURL)
}
