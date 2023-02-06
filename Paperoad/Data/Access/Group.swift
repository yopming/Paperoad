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
    func saveGroup(_ group: inout Group) throws {
        try writer.write { db in
            try group.save(db)
        }
    }
    
    func deleteGroups(ids: [Int64]) throws {
        try writer.write { db in
            _ = try Group.deleteAll(db, keys: ids)
        }
    }
    
    func deleteAllGroups() throws {
        try writer.write { db in
            _ = try Group.deleteAll(db)
        }
    }
    
    func groupsOrderedByNamePublisher() -> AnyPublisher<[Group], Error> {
        ValueObservation
            .tracking(Group.all().orderedByCreateTime().fetchAll)
            .publisher(in: writer, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
