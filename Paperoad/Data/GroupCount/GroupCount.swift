//
//  GroupCount.swift
//  Paperoad
//
//  Created by Tieming on 2/14/23.
//

import GRDB

/// GroupCount struct for the SQL:
/// > SELECT `group`, COUNT(*) as `count` FROM paper GROUP BY `group`;
struct GroupCount: Codable, Equatable, Hashable {
    var group: Int64?
    var count: Int?
}

extension GroupCount: FetchableRecord {}
