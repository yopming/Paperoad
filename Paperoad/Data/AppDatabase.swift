//
//  AppDatabase.swift
//  Paperoad
//
//  Created by Tieming on 2/5/23.
//

import Foundation
import GRDB

struct AppDatabase {
    // creates an `AppDatabase` and make sure the database schema is ready
    init(_ dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    // provides access to the database
    private let dbWriter: any DatabaseWriter
    
    var reader: DatabaseReader {
        dbWriter
    }
}
