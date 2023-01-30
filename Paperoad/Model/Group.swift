//
//  Group.swift
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
struct Group: Identifiable, Hashable {
    // Int64 is the recommended type for auto-incremented database ids.
    // Use nil for groups that are not inserted yet in the database.
    var id: Int64?
    var name: String
    var description: String
    var createTime: Date
    var updateTime: Date
}

extension Group {
    private static let groups = ["Momo", "Bile", "Boo", "Fone", "Elibo", "Tuio"]
    
    /// returns a random group name
    static func randomGroupName() -> String {
        groups.randomElement()!
    }
    
    /// creates a new group with random name
    static func makeRandom() -> Group {
        Group(id: nil, name: randomGroupName(), description: "", createTime: Date(), updateTime: Date())
    }
}

/// Make Player a Codable Record.
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Group: Codable, FetchableRecord, MutablePersistableRecord {
    fileprivate enum Columns {
        static let name = Column(CodingKeys.name)
        static let description = Column(CodingKeys.description)
    }
    
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}
