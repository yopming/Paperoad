//
//  AppDatabaseMigrator.swift
//  Paperoad
//
//  Created by Tieming on 1/28/23.
//

import GRDB

/// The DatabaseMigrator that defines the database schema.
/// See <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/migrations>
extension AppDatabase {
    internal var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        /// speed up development by nuking the database when migrations change
        /// see <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/migrations>
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("v1") { db in
            try self.createGroupTable(db)
            try self.createPaperTable(db)
        }
        return migrator
    }
    
    // MARK: - Group Schema
    /// see <https://github.com/groue/GRDB.swift#create-tables>
    private func createGroupTable(_ db: GRDB.Database) throws {
        try db.create(table: "Groups") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("name", .text).notNull()
            table.column("description", .text).notNull()
            table.column("createTime", .datetime).notNull()
            table.column("updateTime", .datetime).notNull()
        }
    }
    
    // MARK: - Paper Schema
    private func createPaperTable(_ db: GRDB.Database) throws {
        try db.create(table: "Papers") {table in
            table.autoIncrementedPrimaryKey("id")
            table.column("title", .text).notNull()
            table.column("firstAuthor", .text).notNull()
            // TODO record all authors
            table.column("type", .text).notNull()
            table.column("abstract", .text)
            table.column("date", .datetime)
            table.column("doi", .text)
            table.column("isbn", .text)
            table.column("url", .text)
            table.column("publisher", .text)
            table.column("proceedingTitle", .text)
            table.column("conferenceName", .text)
            table.column("place", .text)
            table.column("volumn", .text)
            table.column("pages", .text)
            table.column("series", .text)
            table.column("language", .text)
            table.column("createTime", .datetime).notNull()
            table.column("updateTime", .datetime).notNull()
        }
    }
}
