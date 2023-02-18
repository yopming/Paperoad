//
//  Develop.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import SwiftUI

/// Open library directory where Application Support folder is
struct DevelopCommands: Commands {
    var body: some Commands {
        CommandMenu("Develop") {
            Button("Open Application Support") {
                openApplicationSupportDir()
            }
        }
    }
    
    fileprivate func openApplicationSupportDir() {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dataDirectoryURL = appSupportURL
        
        NSWorkspace.shared.open(dataDirectoryURL)
    }
}
