//
//  DatabaseMigrator.swift
//  Paperoad
//
//  Created by Tieming on 1/28/23.
//

import GRDB

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
    
    private func createAuthortable(_ db: GRDB.Database) throws {
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
