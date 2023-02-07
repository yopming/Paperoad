//
//  PaperRequest.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/7/23.
//

import GRDB
import GRDBQuery
import Combine

struct PaperRequest: Queryable {
    static var defaultValue: [Paper] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Paper], Error> {
        ValueObservation
            .tracking{ db in try Paper.fetchAll(db) }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
