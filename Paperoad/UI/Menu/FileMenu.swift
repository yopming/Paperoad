//
//  File.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/18/23.
//

import SwiftUI

/// Remove "New Window" option from menu file
struct FileCommands: Commands {
    @Binding var showGroupAddSheet: Bool
    @Binding var showPaperAddSheet: Bool
    @Binding var showPaperAddByIdentifierSheet: Bool
    
    var body: some Commands {
        CommandGroup(replacing: .newItem, addition: {})
        
        CommandGroup(after: .newItem, addition: {
            Button("New Group") {
                showGroupAddSheet = true
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command, .shift]
            )
            
            Divider()
            
            Button("New Paper") {
                showPaperAddSheet = true
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command]
            )
            
            Button("New Paper by Identifier") {
                showPaperAddByIdentifierSheet = true
            }
            .keyboardShortcut(
                KeyEquivalent("n"),
                modifiers: [.command, .option]
            )
        })
    }
}
