//
//  AppDatabasePersistence.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import GRDB
import Foundation

extension AppDatabase {
    /// The database for the application
    static let shared = makeShared()
    
    private static func makeShared() -> AppDatabase {
        do {
            // create a folder for storing the SQLite database, as well as temporary files created
            // during normal database operations (https://sqlite.org/tempfiles.html)
            let fileManager = FileManager()
            let folderURL = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("data", isDirectory: true)
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            
            // connect to a database on disk
            // See <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/databaseconnections>
            let dbURL = folderURL.appendingPathComponent("db.sqlite")
            let dbPool = try DatabasePool(path: dbURL.path)
            
            // create the AppDatabase
            let appDatabase = try AppDatabase(dbPool)
            
            // populate the database if its is empty
//            try appDatabase.create
            
            return appDatabase
        } catch {
            // TODO: replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            /// Typical reasons for an error here include:
            /// * the parent directory cannot be created, or disallows writing.
            /// * the database is not accessible, due to permissions or protection when the device is locked.
            /// * the device is out of space.
            /// * the database could not be migrated to its latest schema version.
            fatalError("Unresolved error \(error)")
        }
    }
}
