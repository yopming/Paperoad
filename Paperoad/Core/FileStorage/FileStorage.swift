//
//  FileStorage.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/15/23.
//

import Foundation

class FileStorage {
    static let documentDirectory: URL = {
        let availableDirectories = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
        
        #if DEBUG
        return availableDirectories[0]
            .appendingPathExtension("Paperoad.Debug")
        #else
        return availableDirectories[0]
            .appendingPathExtension("Paperoad")
        #endif
    }()
}
