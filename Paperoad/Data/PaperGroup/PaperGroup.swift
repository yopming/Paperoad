//
//  PaperGroup.swift
//  Paperoad
//
//  Created by Tieming on 2/9/23.
//

import GRDB
import Foundation
import LoremSwiftum

/// Paper - Group should be many-to-one relationship, that is
/// one paper should be in only one group, one group can have multiple papers
struct PaperGroup: Codable, Identifiable, Equatable, Hashable {
    var id: Int64?
    var paperId: Int64
    var groupId: Int64
}

extension PaperGroup {
    static func new(paperId: Int64, groupId: Int64?) -> PaperGroup {
        // groupId should start with 1, 0 represents no group for the paper
        PaperGroup(paperId: paperId, groupId: groupId ?? 0)
    }
}

extension PaperGroup: TableRecord {
    enum Columns {
        static let id = Column(PaperGroup.CodingKeys.id)
        static let paperId = Column(PaperGroup.CodingKeys.paperId)
        static let groupId = Column(PaperGroup.CodingKeys.groupId)
    }
}

extension PaperGroup: FetchableRecord {}

extension PaperGroup: MutablePersistableRecord {
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

extension DerivableRequest<PaperGroup> {
    func orderedByGroup() -> Self {
        order(PaperGroup.Columns.groupId)
    }
}
