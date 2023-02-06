//
//  AppDatabase.swift
//  Paperoad
//
//  Created by Tieming on 2/5/23.
//

import os.log
import Foundation
import GRDB

struct AppDatabase {
    private static let log = OSLog(subsystem: "app.dbms.tgeng.Paperoad", category: "database")
    
    // provides access to the database
    let writer: any DatabaseWriter
    
    // creates an `AppDatabase` and make sure the database schema is ready
    init(_ writer: any DatabaseWriter) throws {
        self.writer = writer
        try migrator.migrate(writer)
    }
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        /// MARK: - table 'group'
        migrator.registerMigration("createGroup") { db in
            try db.create(table: "group") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("createTime", .date).notNull()
                t.column("updateTime", .date).notNull()
            }
        }
        
        return migrator
    }
    
    var reader: DatabaseReader {
        writer
    }
}
