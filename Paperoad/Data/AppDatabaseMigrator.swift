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
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        /// speed up development by nuking the database when migrations change
        /// see <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/migrations>
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("v1") { db in
            try self.createGroupTable(db)
            try self.createPaperTable(db)
            try self.createAuthorTable(db)
        }
        return migrator
    }
    
    private func createGroupTable(_ db: GRDB.Database) throws {
        try db.create(table: "Groups") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("name", .text).notNull()
            table.column("description", .text).notNull()
            table.column("createTime", .datetime).notNull()
            table.column("updateTime", .datetime).notNull()
        }
    }
    
    private func createPaperTable(_ db: GRDB.Database) throws {
        try db.create(table: "Papers") {table in
            table.autoIncrementedPrimaryKey("id")
            table.column("title", .text).notNull()
            table.foreignKey(["id"], references: "Authors", columns: ["authorId"])
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
    
    private func createAuthorTable(_ db: GRDB.Database) throws {
        try db.create(table: "Authors") {table in
            table.autoIncrementedPrimaryKey("id")
            table.column("orcId", .text)
            table.column("firstName", .text)
            table.column("middleName", .text)
            table.column("lastName", .text)
            table.column("createTime", .datetime).notNull()
            table.column("updateTime", .datetime).notNull()
        }
    }
}
