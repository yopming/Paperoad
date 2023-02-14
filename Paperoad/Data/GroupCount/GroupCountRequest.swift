//
//  GroupCountRequest.swift
//  Paperoad
//
//  Created by Tieming on 2/14/23.
//

import GRDB
import GRDBQuery
import Combine

struct GroupCountRequest: Queryable {
    static var defaultValue: [GroupCount] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[GroupCount], Error> {
        ValueObservation
            .tracking { db in
                try GroupCount.fetchAll(
                    db,
                    sql: "SELECT `group`, COUNT(*) AS `count` FROM paper WHERE deleted == false GROUP BY `group`;"
                )
            }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
