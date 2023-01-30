//
//  AppDatabase.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import GRDB
import Combine
import os.log

/// AppDatabase lets the application access the database.
/// It applies the practices recommended at:
/// <https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md>
final class AppDatabase {
    /// Provides access to the database.
    /// Application can use a `DatabasePool`, and tests can use a fast in-memory `DatabaseQueue`
    /// See <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/databaseconnections>
    internal let dbWriter: any DatabaseWriter
    
    /// Creates an `AppDatabase`, and make sure the database scheme is ready
    init(_ dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
}
