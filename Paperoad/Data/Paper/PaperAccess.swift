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
    func readPapersInGroup(groupId: Int64) throws -> [Paper] {
        var papers: [Paper] = { [] }()
        try reader.read { db in
            let groupIdString = String(groupId)
            papers = try Paper.fetchAll(
                db,
                sql: "SELECT * FROM paper WHERE paper.id in (SELECT paperId FROM papergroup WHERE papergroup.groupId = ?)",
                arguments: [groupIdString]
            )
        }
        
        return papers
    }
    
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
