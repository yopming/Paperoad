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
    
    @Query(PaperRequest(), in: \.appDatabase) private var papers: [Paper]
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
    let par: String
    
    @State private var selectedPaperToUpdate: Paper?
    @State private var selectedPapers = Set<Paper>()
    
    var body: some View {
//        Table(papers, selection: $selectedPapers) {
//            TableColumn("Title", value: \.title)
//            TableColumn("Authors") { paper in
//                Text(paper.authors ?? "")
//            }
//        }
        List(papers, id: \.self, selection: $selectedPapers) { paper in
            PaperListItem(
                title: paper.title,
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
                        selectedPaperToUpdate = selectedPapers.first
                    }
                }
                
                Button("Delete") {}
            }
        }
        
        .sheet (item: $selectedPaperToUpdate) { paper in
            PaperUpdateView(paper: paper)
        }
        
        Text("\(selectedPapers.count) papers selected \(par)")
            .padding()
    }
     
    
    // MAKR: - Update Button
//    private var updateButton: some View {
//        var paper:Paper
//
//        Button("Update Paper") {
//            showSheet = .update
//        }
//        .sheet(item: $showSheet) {_ in
//            PaperUpdateView(
//                paper: paper,
//                showSheet: $showSheet
//            )
//        }
//    }
    
    // MARK: - Permanently Delete Button
//    private var permanentlyDeleteButton: some View {
//        Button("Delete Permanently") {
//            showSheet = .delete
//        }
//    }
}


// enum for sheets in PapersView
enum PapersSheetView: Identifiable {
    var id: Self { self }
    case update, delete
}
