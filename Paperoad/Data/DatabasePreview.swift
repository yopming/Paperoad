//
//  DatabasePreview.swift
//  Paperoad
//
//  Created by Tieming on 1/28/23.
//

import GRDB

extension Database {
    static let preview: Database = {
        let writer = DatabaseQueue()
        return try! Database(writer)
    }()
}
