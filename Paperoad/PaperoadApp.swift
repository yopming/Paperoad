//
//  PaperoadApp.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

@main
struct PaperoadApp: App {
    @StateObject var appState = AppState()
    
    @Default(\.theme) var theme // global dark mode or light mode
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appDatabase, .persistence)
                .environmentObject(appState)
                .preferredColorScheme(
                    theme == "Dark" ? .dark : (theme == "Light" ? .light : nil)
                )
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands {
            SidebarCommands()
            
            FileCommands(showGroupAddSheet: $appState.showGroupAddSheet)
            DevelopCommands()
            
//            CommandMenu("Test") {
//                Button("new group") {
//                    appState.showGroupAddSheet = true
//                }
//            }
        }
        
        Settings {
            SettingsView()
                .preferredColorScheme(
                    theme == "Dark" ? .dark : (theme == "Light" ? .light : nil)
                )
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

// Defines a new environment key that grants access to an AppDatabase
private struct AppDatabaseKey: EnvironmentKey {
    static var defaultValue: AppDatabase { .empty() }
}

extension EnvironmentValues {
    var appDatabase: AppDatabase {
        get { self[AppDatabaseKey.self] }
        set { self[AppDatabaseKey.self] = newValue }
    }
}

