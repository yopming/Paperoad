//
//  AppDatabaseReader.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import GRDB

extension AppDatabase {
    /// Provides a read-only access to the database
    var reader: DatabaseReader {
        dbWriter
    }
}
