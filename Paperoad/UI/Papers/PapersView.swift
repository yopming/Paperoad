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
    
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
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
                    if selectedPapers.count == 1 {
                        Button("Update Paper") {
                            isPaperUpdateViewPresented = true
                        }
                        .sheet(
                            isPresented: $isPaperUpdateViewPresented,
                            content: {
                                PaperUpdateView(
                                    paper: paper,
                                    presented: $isPaperUpdateViewPresented
                                )
                            }
                        )
                    }
                    
                    Button("Delete") {}
                    
                    Divider()
                    Button("Delete Permanently") {
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
    
    
    // MAKR: - Update Button
    private var updateButton: some View {
        var paper:Paper
        
        Button("Update Paper") {
            showSheet = .update
        }
        .sheet(item: $showSheet) {_ in
            PaperUpdateView(
                paper: paper,
                showSheet: $showSheet
            )
        }
    }
    
    // MARK: - Permanently Delete Button
    private var permanentlyDeleteButton: some View {
        Button("Delete Permanently") {
            showSheet = .delete
        }
    }
}


// enum for sheets in PapersView
enum PapersSheetView: Identifiable {
    var id: Self { self }
    case update, delete
}
