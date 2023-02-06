//
//  Group.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import GRDB
import Foundation
import Combine

extension AppDatabase {
    // validation
    enum ValidationError: LocalizedError {
        case missingName
        
        var errorDescription: String? {
            switch self {
            case .missingName:
                return "Please provide a name."
            }
        }
    }
    
    // save (insert or update)
    func saveGroup(_ group: inout Group) throws {
        if group.name.isEmpty {
            throw ValidationError.missingName
        }
        
        try writer.write { db in
            try group.save(db)
        }
    }
    
    func deleteGroups(ids: [Int64]) throws {
        try writer.write { db in
            _ = try Group.deleteAll(db, ids: ids)
        }
    }
    
    func deleteAllGroups() throws {
        try writer.write { db in
            _ = try Group.deleteAll(db)
        }
    }
}
