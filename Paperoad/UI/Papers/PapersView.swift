//
//  PapersView.swift
//  Paperoad
//
//  Created by Tieming on 1/27/23.
//

import SwiftUI

struct PapersView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Paper.title, ascending: false),
            NSSortDescriptor(keyPath: \Paper.year, ascending: true)
        ]
    ) internal var papers: FetchedResults<Paper>
    
    @State private var sortOrder = [
        KeyPathComparator(\Paper.title),
        KeyPathComparator(\Paper.year)
    ]
    
    @State private var selectedPapers = Set<Paper.ID>()
    
    @State private var isPaperDeleteConfirmPresented: Bool = false
    
    let par: String
    
    var body: some View {
        List(selection: $selectedPapers) {
            ForEach(papers, id: \.self.id) { paper in
                PaperListItem(
                    title: paper.title!,
                    authors: paper.authors ?? "",
                    year: paper.year ?? "",
                    publication: paper.publication ?? ""
                )
                .listRowSeparator(.visible)
                .listRowSeparatorTint(.gray.opacity(0.25))
                .padding([.vertical], 3)
                .contextMenu {
                    Button("Delete") {
                        isPaperDeleteConfirmPresented = true
                        viewContext.delete(paper)
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                }
            }
        }
        
        Text("\(selectedPapers.count) papers selected \(par)")
            .padding()
    }
}

