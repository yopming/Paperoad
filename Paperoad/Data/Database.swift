//
//  Database.swift
//  Database manager for Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import GRDB
import Foundation

struct Database {
    let writer: DatabaseWriter
    
    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
    }
    
    var reader: DatabaseReader {
        writer
    }
}

// MARK: - Preview
extension Database {
    static let preview: Database = {
        let writer = DatabaseQueue()
        return try! Database(writer)
    }()
}

// MARK: - Migrator
extension Database {
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("v1") { db in
        }
        return migrator
    }
    
}

// MARK: - Persistent
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
            // BreadBuddy github reddit
        } catch {
            fatalError("Unresolved error: \(error)")
        }
    }()
}
