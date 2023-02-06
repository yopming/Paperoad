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
struct Group: Identifiable, Equatable {
    var id: Int64?
    var name: String
    var createTime: Date
    var updateTime: Date
}


extension Group {
    static func new() -> Group {
        Group(
            id: nil,
            name: "",
            createTime: Date(),
            updateTime: Date()
        )
    }
    
    static func random() -> Group {
        Group(
            id: nil,
            name: Lorem.word,
            createTime: Date(),
            updateTime: Date()
        )
    }
}

extension Group: Codable, FetchableRecord, MutablePersistableRecord {
    // define database columns from CodingKeys
    fileprivate enum Columns {
        static let name = Column(CodingKeys.name)
        static let createTime = Column(CodingKeys.createTime)
        static let updateTime = Column(CodingKeys.updateTime)
    }
    
    // updates a group id after it has been inserted in the database
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

// MAKR: - Database Requests
extension DerivableRequest<Group> {
    func orderedByName() -> Self {
        order(Group.Columns.name.collating(.localizedCaseInsensitiveCompare))
    }
    
    func orderedByCreateTime() -> Self {
        order(Group.Columns.createTime.collating(.unicodeCompare))
    }
}
