//
//  Develop.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import SwiftUI

internal func openApplicationSupportDir() {
    let fileManager = FileManager.default
    let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    let dataDirectoryURL = appSupportURL

    NSWorkspace.shared.open(dataDirectoryURL)
}
