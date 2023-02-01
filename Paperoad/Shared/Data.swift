//
//  Data.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import Foundation

enum PublicationConfig {
    enum Types: String, CaseIterable {
        case book = "Book"
        case conference = "Conference Paper"
        case journal = "Journal Article"
        case webpage = "Web Page"
        case other = "Other"
    }
    
    enum IdTypes: String, CaseIterable {
        case arxiv = "arXiv ID"
        case doi = "DOI"
        case isbn = "ISBN"
    }
}
