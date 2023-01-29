//
//  Database.swift
//  Database manager for Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import GRDB
import Foundation

struct Database {
    let writer: DatabaseWriter
    
    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
    }
    
    var reader: DatabaseReader {
        writer
    }
}
