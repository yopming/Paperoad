//
//  PaperAccess.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/7/23.
//

import GRDB
import Combine
import Foundation

extension AppDatabase {
    // insert or update
    func savePaper(_ paper: inout Paper) throws {
        if paper.title.isEmpty {
            throw ValidationError.missingPaperTitle
        }
        
        try writer.write { db in
            try paper.save(db)
        }
    }
    
    func deletePapers(ids: [Int64]) throws {
        try writer.write { db in
            _ = try Paper.deleteAll(db, ids: ids)
        }
    }
    
    func deleteAllPapers() throws {
        try writer.write { db in
            _ = try Paper.deleteAll(db)
        }
    }
}
