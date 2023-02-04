//
//  PapersViewModel.swift
//  Paperoad
//
//  Created by Tieming on 2/3/23.
//

import Foundation
import SwiftUI
import CoreData

extension PapersView {
    func deletePapers(offsets: IndexSet) {
        withAnimation {
            offsets.map{ papers[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteSelectedPapers(selectedPapers: Set<Paper.ID>) {
//        ForEach(0..<selectedPapers.count, id: \.self) {paper in
//            print(paper)
//        }
    }
}
