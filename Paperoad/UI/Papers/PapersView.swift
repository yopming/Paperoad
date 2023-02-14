//
//  PapersView.swift
//  Paperoad
//
//  Created by Tieming on 1/27/23.
//

import SwiftUI
import GRDBQuery

struct PapersView: View {
    @Environment(\.appDatabase) private var appDatabase

    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
    @State private var selectedPaperToUpdate: Paper?
    @State private var selectedPapers = Set<Paper>()
    
    var papers: [Paper]
    
    var body: some View {
        // TODO alternative representation style with table instead of list
//        Table(papers, selection: $selectedPapers) {
//            TableColumn("Title", value: \.title)
//            TableColumn("Authors") { paper in
//                Text(paper.authors ?? "")
//            }
//        }
        
        List(self.papers, id: \.self, selection: $selectedPapers) { paper in
            PaperListItem(paper: paper)
                .listRowSeparator(.visible)
                .listRowSeparatorTint(.gray.opacity(0.25))
                .padding([.vertical], 3)
                .contextMenu {
                    PapersContextMenuAddGroup(paper: paper)
                    
                    if selectedPapers.count == 1 {
                        Button("Update Paper") {
                            selectedPaperToUpdate = selectedPapers.first
                        }
                    }
                    
                    Button("Delete") { trash() }
                    
                    // For debug, print data of one paper in the list
                    #if DEBUG
                    Button("Console.log") { consoleLog() }
                    #endif
                }
        }
        
        .sheet (
            item: $selectedPaperToUpdate,
            onDismiss: {
                // when update done, clear "selectedPapers"
                selectedPapers.removeAll()
            },
            content: { paper in
                PaperUpdateView(paper: paper)
            }
        )
        
        Text("\(selectedPapers.count) papers selected.")
            .padding()
    }
     
    private func trash() {
        while !selectedPapers.isEmpty {
            guard var currentPaper = selectedPapers.popFirst() else { return }
            currentPaper.deleted = true
            currentPaper.updateTime = Date()
            do {
                try appDatabase.savePaper(&currentPaper)
            } catch {
                errorAlertIsPresented = true
                errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Trash Paper error occurred"
            }
        }
    }
    
    private func consoleLog() {
        print(selectedPapers.first ?? "No paper selected")
    }
    
}
