//
//  DatabasePersistent.swift
//  Paperoad
//
//  Created by Tieming on 1/28/23.
//

import Foundation
import GRDB

extension Database {
    static let persistent: Database = {
        do {
            let fileManager = FileManager()
            let folder = try fileManager
                .url(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )
                .appendingPathComponent("data", isDirectory: true)
            
            // command line with "-reset" argument, remove all db files
            if CommandLine.arguments.contains("-reset") {
                try? fileManager.removeItem(at: folder)
            }
            
            try fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
            let url = folder.appendingPathComponent("db.sqlite")
            let writer = try DatabasePool(path: url.path)
            let database = try Database(writer)
            return database
        } catch {
            fatalError("Unresolved error: \(error)")
        }
    }()
}

