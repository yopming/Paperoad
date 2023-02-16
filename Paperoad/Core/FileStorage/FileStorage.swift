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
        print(availableDirectories)
        return availableDirectories[0]
            .appendingPathExtension("/blob")
    }()
}
