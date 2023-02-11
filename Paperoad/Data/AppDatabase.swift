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
        
        // MARK: - table 'group'
        migrator.registerMigration("createGroup") { db in
            try db.create(table: "group") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("createTime", .date).notNull()
                t.column("updateTime", .date).notNull()
            }
        }
        
        // MARK: - table 'paper'
        migrator.registerMigration("createPaper") { db in
            try db.create(table: "paper") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("title", .text).notNull()
                t.column("publication", .text)
                t.column("year", .text)
                t.column("authors", .text)
                t.column("publisher", .text)
                t.column("type", .integer)
                t.column("doi", .text)
                t.column("isbn", .text)
                t.column("arxiv", .text)
                t.column("group", .integer)
                t.column("abstract", .text)
                t.column("note", .text)
                t.column("number", .text)
                t.column("volume", .text)
                t.column("pages", .text)
                t.column("url", .text)
                t.column("deleted", .boolean).notNull()
                t.column("createTime", .date).notNull()
                t.column("updateTime", .date).notNull()
            }
        }
        
        // MARK: - table 'paper_group'
        migrator.registerMigration("createPaperGroup") { db in
            try db.create(table: "papergroup") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("paperId", .integer).notNull()
                t.column("groupId", .integer)
            }
        }
        
        return migrator
    }
    
    var reader: DatabaseReader {
        writer
    }
}
