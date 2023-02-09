//
//  PaperGroupAccess.swift
//  Paperoad
//
//  Created by Tieming on 2/9/23.
//

import GRDB
import Combine
import Foundation

extension AppDatabase {
    func savePaperGroup(_ pair: inout PaperGroup) throws {
        try writer.write { db in
            try pair.save(db)
        }
    }
    
    func deletePaperGroupPairs(ids: [Int64]) throws {
        try writer.write { db in
            _ = try PaperGroup.deleteAll(db, ids: ids)
        }
    }
    
    func deleteAllPaperGroupPairs() throws {
        try writer.write { db in
            _ = try PaperGroup.deleteAll(db)
        }
    }
}
