//
//  AppDatabaseWriter.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import GRDB

extension AppDatabase {
    /// Saves (insert or update) a group.
    /// When the method returns, the group is present in the database, and its id is not nil
    func saveGroup(_ group: inout Group) throws {
        try dbWriter.write {db in
            try group.save(db)
        }
    }
    
    /// delete the specified group
    func deleteGroups(ids: [Int64]) throws {
        try dbWriter.write {db in
            _ = try Group.deleteAll(db, ids: ids)
        }
    }
    
    /// delete all groups
    func deleteAllGroups() throws {
        try dbWriter.write {db in
            _ = try Group.deleteAll(db)
        }
    }
}
