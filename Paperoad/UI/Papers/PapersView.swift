//
//  PapersView.swift
//  Paperoad
//
//  Created by Tieming on 1/27/23.
//

import SwiftUI

struct PapersView: View {
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
    let par: String
    
    var body: some View {
        Text("PapersView")
//        List(selection: $selectedPapers) {
//            ForEach(papers, id: \.self.id) { paper in
//                PaperListItem(
//                    title: paper.title!,
//                    authors: paper.authors ?? "",
//                    year: paper.year ?? "",
//                    publication: paper.publication ?? ""
//                )
//                .listRowSeparator(.visible)
//                .listRowSeparatorTint(.gray.opacity(0.25))
//                .padding([.vertical], 3)
//                .contextMenu {
//                    if selectedPapers.count == 1 {
//                        Button("Update Paper") { }
//                        .sheet(
//                            isPresented: $isPaperUpdateViewPresented,
//                            content: {
//                                PaperUpdateView()
//                            }
//                        )
//                    }
//
//                    Button("Delete") {}
//
//                    Divider()
//                    Button("Delete Permanently") {
//                    }
//
//                }
//            }
//        }
//
//        Text("\(selectedPapers.count) papers selected \(par)")
        Text("\(par)")
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
