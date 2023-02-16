//
//  Persistence.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import GRDB
import Foundation

extension AppDatabase {
    static let persistence = makeShared()
    
    private static func makeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            let folderURL = try fileManager
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("database", isDirectory: true)
            
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            
            let dbURL = folderURL.appendingPathComponent("db.sqlite")
            let dbPool = try DatabasePool(path: dbURL.path)
            let appDatabase = try AppDatabase(dbPool)
            
            return appDatabase
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    static func empty() -> AppDatabase {
        let dbQueue = try! DatabaseQueue()
        return try! AppDatabase(dbQueue)
    }
}
