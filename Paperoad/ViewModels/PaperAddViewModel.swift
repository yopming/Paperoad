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
        publication: String,
        year: String,
        group: String
    ) {
        withAnimation {
            let newPaper = Paper(context: viewContext)
            newPaper.id = UUID()
            newPaper.title = title
            newPaper.authors = authors
            newPaper.publication = publication
            newPaper.year = year
            newPaper.group = group
            
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
            newPaper.id = UUID()
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
