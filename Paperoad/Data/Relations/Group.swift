//
//  Group.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/30/23.
//

import GRDB
import Combine

extension AppDatabase {
    // MARK: - Read
    func groups() throws -> [Group] {
        try dbWriter.read {db in
            try Group.fetchAll(db)
        }
    }
    
    // MARK: - Save (Insert or Update)
    func saveGroup(_ group: inout Group) throws {
        try dbWriter.write{db in
            try group.save(db)
        }
    }
    
    // MARK: - Delete specific
    func deleteGroup(ids: [Int64]) throws {
        try dbWriter.write{db in
            _ = try Group.deleteAll(db, keys: ids)
        }
    }
    
    // MARK: - Delete all
    func deleteAllGroups() throws {
        try dbWriter.write{db in
            _ = try Group.deleteAll(db)
        }
    }
    
    // Returns a publisher that tracks changes in groups ordered by name
    func groupsOrderedByTitlePublisher() -> AnyPublisher<[Group], Error> {
        ValueObservation
            .tracking(Group.all().orderedByName().fetchAll)
            .publisher(in: dbWriter, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
