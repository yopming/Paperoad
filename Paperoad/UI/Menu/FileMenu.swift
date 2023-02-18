//
//  File.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/18/23.
//

import SwiftUI

/// Remove "New Window" option from menu file
struct FileCommands: Commands {
    var body: some Commands {
        CommandGroup(replacing: .newItem, addition: {})
        
        CommandGroup(after: .newItem, addition: {
            Button("New Group") {
                // TODO: open new group button
                SidebarActionView().openNewGroupFormView()
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command, .shift]
            )
            
            Divider()
            
            Button("New Paper") {
                ToolbarMiddle().openPaperAddView()
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command]
            )
            Button("New Paper by Identifier") {
                ToolbarMiddle().openPaperAddByIdView()
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command, .option]
            )
        })
    }
}
