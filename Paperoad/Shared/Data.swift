//
//  Data.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import Foundation

enum PaperConfig {
    enum Types: String, CaseIterable {
        case book = "Book"
        case conference = "Conference Paper"
        case journal = "Journal Article"
        case webpage = "Web Page"
        case other = "Other"
    }
    
    enum IdTypes: String, CaseIterable {
        case doi = "DOI"
        case arxiv = "arXiv ID"
        case isbn = "ISBN"
    }
}


enum AppConfig {
    // Dark mode, light mode, or follow system appearnace
    enum Appearance: String, CaseIterable, Equatable {
        case system = "Follow System"
        case light = "Light"
        case dark = "Dark"
    }
}
