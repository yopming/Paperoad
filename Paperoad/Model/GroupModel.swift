//
//  GroupModel.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import GRDB
import Foundation

/// The Group struct.
///
/// Identifiable conformance supports type-safe GRDB primary key methods.
/// Hashable conformance supports table view updates.
struct Group: Identifiable, Codable {
    // Int64 is the recommended type for auto-incremented database ids.
    // Use nil for groups that are not inserted yet in the database.
    var id: Int64?
    var name: String
    var description: String?
    var createTime: Date
    var updateTime: Date
}

// MARK: - SQL generation
extension Group: TableRecord {
    enum Columns {
        static let id = Column(Group.CodingKeys.id)
        static let name = Column(Group.CodingKeys.name)
        static let description = Column(Group.CodingKeys.description)
        static let createTime = Column(Group.CodingKeys.createTime)
        static let updateTime = Column(Group.CodingKeys.updateTime)
    }
}

// MARK: - Fetching method
extension Group: FetchableRecord {}

// MARK: - Persistence method
extension Group: MutablePersistableRecord {
    // update auto-incremented id upon successful insertion
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - Database requests
extension DerivableRequest where RowDecoder == Group {
    func orderedByName() -> Self {
        order(Group.Columns.name)
    }
}

extension Group {
    private static let names: [String] = ["Security", "Blockchain", "AI", "CV"]
    
    /// creates a new group with random name and empty description
    static func newRandom() -> Group {
        Group(name: randomName(), createTime: Date(), updateTime: Date())
    }
    
    static func randomName() -> String {
        names.randomElement()!
    }
}
