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
struct Paper: Codable, Identifiable, Equatable, Hashable {
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
    var abstract: String?
    var note: String?
    var number: String?
    var volume: String?
    var pages: String?
    var url: String?
    var attachment: String?
    var group: Int64?
    var deleted: Bool
    var createTime: Date
    var updateTime: Date
}

extension Paper {
    /// new paper with at leat "title", possibly "publication", "year", and "authors"
    static func new(title: String, pub: String?, year: String?, authors: String?) -> Paper {
        Paper(
            title: title,
            publication: pub ?? "",
            year: year ?? "",
            authors: authors ?? "",
            deleted: false,
            createTime: Date(),
            updateTime: Date()
        )
    }
    
    /// add a paper by uploading a file, "title" would be the file's filename
    static func newFile(title: String, attachment: String) -> Paper {
        Paper(
            title: title,
            attachment: attachment,
            deleted: false,
            createTime: Date(),
            updateTime: Date()
        )
    }
    
    /// add a paper with random data
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
        static let abstract = Column(Paper.CodingKeys.abstract)
        static let note = Column(Paper.CodingKeys.note)
        static let number = Column(Paper.CodingKeys.number)
        static let volume = Column(Paper.CodingKeys.volume)
        static let pages = Column(Paper.CodingKeys.pages)
        static let url = Column(Paper.CodingKeys.url)
        static let attachment = Column(Paper.CodingKeys.attachment)
        static let group = Column(Paper.CodingKeys.group)
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
