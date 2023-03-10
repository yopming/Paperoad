//
//  PaperRequest.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/7/23.
//

import GRDB
import GRDBQuery
import Combine

// a query for all papers (no papers with deleted == true)
struct PaperRequest: Queryable {
    static var defaultValue: [Paper] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Paper], Error> {
        ValueObservation
            .tracking { db in try Paper.filter(Paper.Columns.deleted == false).fetchAll(db) }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}

// a query fro all papers with those in trash
struct PaperAllRequest: Queryable {
    static var defaultValue: [Paper] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Paper], Error> {
        ValueObservation
            .tracking { db in try Paper.fetchAll(db) }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}


// a query for all trashed papers
struct PaperTrashedRequest: Queryable {
    static var defaultValue: [Paper] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Paper], Error> {
        ValueObservation
            .tracking { db in try Paper.filter(Paper.Columns.deleted == true).fetchAll(db) }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}

// query for unfiled paper
struct PaperUnfiledRequest: Queryable {
    static var defaultValue: [Paper] { [] }

    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Paper], Error> {
        ValueObservation
            .tracking { db in
                try Paper
                    .filter(Paper.Columns.group == nil || Paper.Columns.group == 0)
                    .fetchAll(db)
            }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
