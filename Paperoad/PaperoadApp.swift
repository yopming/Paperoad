//
//  PaperoadApp.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

@main
struct PaperoadApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            SidebarCommands()
            
            // remove "New Window" option from menu File
            CommandGroup(replacing: .newItem, addition: {})
        }
        
        Settings {
            PreferenceView()
        }
    }
}
