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
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            CommandGroup(after: .appInfo) {
                EmptyView()
            }
        }
        Settings {
            SettingView()
        }
    }
}
