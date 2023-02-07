//
//  Paper.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/6/23.
//

import GRDB
import Foundation
import LoremSwiftum

/// Paper struct
struct Paper: Codable, Identifiable, Equatable {
    var id: Int64?
    var title: String
    var publication: String?
    var year: String?
    var authors: String?
    var publisher: String?
    var type: Int16?
    var doi: String?
    var isbn: String?
    var arxiv: String?
    var group: Int64?
    var abstract: String?
    var note: String?
    var number: String?
    var pages: String?
    var url: String?
    var volume: String?
    var deleted: Bool
    var createTime: Date
    var updateTime: Date
}

extension Paper {
    static func new(title: String) -> Paper {
        Paper(title: title, deleted: false, createTime: Date(), updateTime: Date())
    }
    
    static func newEssential(title: String, pub: String, year: String, authors: String) -> Paper {
        Paper(
            title: title,
            publication: pub,
            year: year,
            authors: authors,
            deleted: false,
            createTime: Date(),
            updateTime: Date()
        )
        
    }
    
    static func random() -> Paper {
        Paper(
            title: Lorem.title,
            publication: Lorem.words(3),
            year: "2020",
            authors: Lorem.fullName,
            deleted: false,
            createTime: Date(),
            updateTime: Date()
        )
    }
}


// SQL generation
extension Paper: TableRecord {
    enum Columns {
        static let id = Column(Paper.CodingKeys.id)
        static let title = Column(Paper.CodingKeys.title)
        static let publication = Column(Paper.CodingKeys.publication)
        static let year = Column(Paper.CodingKeys.year)
        static let authors = Column(Paper.CodingKeys.authors)
        static let publisher = Column(Paper.CodingKeys.publisher)
        static let type = Column(Paper.CodingKeys.type)
        static let doi = Column(Paper.CodingKeys.doi)
        static let isbn = Column(Paper.CodingKeys.isbn)
        static let arxiv = Column(Paper.CodingKeys.arxiv)
        static let group = Column(Paper.CodingKeys.group)
        static let abstract = Column(Paper.CodingKeys.abstract)
        static let note = Column(Paper.CodingKeys.note)
        static let number = Column(Paper.CodingKeys.number)
        static let pages = Column(Paper.CodingKeys.pages)
        static let url = Column(Paper.CodingKeys.url)
        static let volume = Column(Paper.CodingKeys.volume)
        static let deleted = Column(Paper.CodingKeys.deleted)
        static let createTime = Column(Paper.CodingKeys.createTime)
        static let updateTime = Column(Paper.CodingKeys.updateTime)
    }
}

// Fetching methods
extension Paper: FetchableRecord {}

// Persistence methods
extension Paper: MutablePersistableRecord {
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

// Database requests
extension DerivableRequest<Paper> {
    func orderedByTitle() -> Self {
        order(Paper.Columns.title.collating(.localizedCaseInsensitiveCompare))
    }
    
    func orderedByTitleDesc() -> Self {
        order(Paper.Columns.title.collating(.localizedCaseInsensitiveCompare).desc)
    }
    
    func orderedByYear() -> Self {
        order(Paper.Columns.year.collating(.unicodeCompare))
    }
    
    func orderedByYearDesc() -> Self {
        order(Paper.Columns.year.collating(.unicodeCompare).desc)
    }
}
