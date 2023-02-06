//
//  AppDatabaseMigrator.swift
//  Paperoad
//
//  Created by Tieming on 2/5/23.
//

import GRDB

extension AppDatabase {
    // DatabaseMigrator defines the database schema
    internal var migrator: DatabaseMigrator {
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
}
