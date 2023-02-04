//
//  PaperAddViewModel.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import SwiftUI
import CoreData
import LoremSwiftum

extension PaperAddView {
    func addPaper(
        title: String,
        authors: String,
        publicationType: Int16,
        publication: String,
        publisher: String,
        year: String,
        volume: String,
        pages: String,
        number: String,
        arxiv: String,
        doi: String,
        url: String,
        note: String
    ) {
        withAnimation {
            let newPaper = Paper(context: viewContext)
            newPaper.title = title
            newPaper.authors = authors
            newPaper.type = publicationType
            newPaper.publication = publication
            newPaper.publisher = publisher
            newPaper.year = year
            newPaper.volume = volume
            newPaper.pages = pages
            newPaper.number = number
            newPaper.arxiv = arxiv
            newPaper.doi = doi
            newPaper.url = url
            newPaper.note = note
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    /// DEBUG, add a random paper with meta data generation
    func addRandomPaper() {
        withAnimation {
            let newPaper = Paper(context: viewContext)
            newPaper.title = Lorem.sentence
            newPaper.authors = Lorem.fullName + Lorem.fullName + Lorem.fullName
            newPaper.publication = Lorem.words(4)
            newPaper.year = "2020"
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    }
}
