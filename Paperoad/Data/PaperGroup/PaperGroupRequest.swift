//
//  PaperGroupRequest.swift
//  Paperoad
//
//  Created by Tieming on 2/9/23.
//

import GRDB
import GRDBQuery
import Combine

// a query for all pairs of <Paper, Group>
struct PaperGroupRequest: Queryable {
    static var defaultValue: [PaperGroup] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[PaperGroup], Error> {
        ValueObservation
            .tracking { db in
                try PaperGroup.fetchAll(db)
            }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
