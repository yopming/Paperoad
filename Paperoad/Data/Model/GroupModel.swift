//
//  Group.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import Foundation
import GRDB
import LoremSwiftum

/// Group struct
///
/// Identifiable conformance supports SwiftUI list animations,
/// and type-safe GRDB primary key methods.
/// Equatable conformance supports tests.
struct Group: Codable, Identifiable {
    var id: Int64?
    var name: String
    var createTime: Date
    var updateTime: Date
}

// SQL generation
extension Group: TableRecord {
    enum Columns {
        static let id = Column(Group.CodingKeys.id)
        static let name = Column(Group.CodingKeys.name)
        static let createTime = Column(Group.CodingKeys.createTime)
        static let updateTime = Column(Group.CodingKeys.updateTime)
    }
}

// Fetching methods
extension Group: FetchableRecord {}

// Persistence methods
extension Group: MutablePersistableRecord {
    // update auto incremented id upon successful insertion
    mutating func didInsert(with rowId: Int64, for column: String?) {
        id = rowId
    }
}

// Database requests
extension DerivableRequest where RowDecoder == Group {
    func orderedByName() -> Self {
        order(Group.Columns.name.collating(.localizedCaseInsensitiveCompare))
    }
    
    func orderedByCreateTime() -> Self {
        order(Group.Columns.createTime.desc, Group.Columns.name)
    }
}

extension Group {
    static func new() -> Group {
        Group(id: nil, name: "", createTime: Date(), updateTime: Date())
    }
    
    static func random() -> Group {
        Group(id: nil, name: Lorem.word, createTime: Date(), updateTime: Date())
    }
}
