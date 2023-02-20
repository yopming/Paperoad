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
    @Environment(\.openDocument) private var openDocument
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
//    @State private var selectedPaperToUpdate: Paper?
//    @State private var selectedPapers = Set<Paper>()
    @State private var selectedPaperIds = Set<Paper.ID>()
    
    @State private var sortByTitle = [KeyPathComparator(\Paper.title)]
    @State private var sortByYear = [KeyPathComparator(\Paper.year)]
    
    // for single selection:
    
    var papers: [Paper]
    // special string to indicate current destination
    var category: String
    
    var body: some View {
        // TODO alternative representation style with table instead of list
        
        HStack {
            Table(sortedPapers, selection: $selectedPaperIds, sortOrder: $sortByTitle) {
                TableColumn("Title", value: \.title)
                    .width(min: 300)
                TableColumn("Authors") { paper in Text(paper.authors ?? "" ) }
                    .width(min: 100, ideal: 50)
                TableColumn("Year") { paper in Text(paper.year ?? "") }
                    .width(35)
                TableColumn("Publication") { paper in Text(paper.publication ?? "") }
                    .width(min: 150, ideal: 100)
            }
            
            // if seletedPaperIds.count == 1 will make PaperTableItemDetail
            // shows only when one paper is selected
            if let selectedPaper = selectedPaper {
                PaperTableItemDetail(paper: selectedPaper)
                    .padding()
                    .frame(width: 250)
            } else {
                Text("Select one paper for more details.")
                    .padding()
                    .frame(width: 250)
            }
        }
        
//        List(self.papers, id: \.self, selection: $selectedPapers) { paper in
//            PaperListItem(paper: paper, category: category)
//                .listRowSeparator(.visible)
//                .listRowSeparatorTint(.gray.opacity(0.25))
//                .padding([.vertical], 3)
//                .contextMenu {
//                    PapersContextMenuAddGroup(paper: paper)
//
//                    if selectedPapers.count == 1 {
//                        Button("Update Paper") {
//                            selectedPaperToUpdate = selectedPapers.first
//                        }
//
//
//                    Button("Delete") { trash() }
//
//                    // TODO: put back and delete permanantely in Trash
//
//                    // For debug, print data of one paper in the list
//                    #if DEBUG
//                    Button("Console.log") { consoleLog() }
//                    #endif
//                }
////                .contentShape(Rectangle())
////                .background(Color.gray)
////                .gesture(tapGesture)
//        }
//
//        .sheet (
//            item: $selectedPaperToUpdate,
//            onDismiss: {
//                // when update done, clear "selectedPapers"
//                selectedPapers.removeAll()
//            },
//            content: { paper in
//                PaperUpdateView(paper: paper)
//            }
//        )
        
        Text("\(selectedPaperIds.count) papers selected.")
            .padding()
    }
    
    var sortedPapers: [Paper] {
        return papers.sorted(using: sortByTitle)
    }
    
    var selectedPaper: Paper? {
        guard let selectedPaperId = selectedPaperIds.first else { return nil }
        let selectedPaper = papers.first {
            $0.id == selectedPaperId
        }
        return selectedPaper
    }
     
//    private func trash() {
//        while !selectedPapers.isEmpty {
//            guard var currentPaper = selectedPapers.popFirst() else { return }
//            currentPaper.deleted = true
//            currentPaper.updateTime = Date()
//            do {
//                try appDatabase.savePaper(&currentPaper)
//            } catch {
//                errorAlertIsPresented = true
//                errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Trash Paper error occurred"
//            }
//        }
//    }
//
//    private func consoleLog() {
//        print(selectedPapers.first ?? "No paper selected")
//    }
    
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static let papers = [
        Paper(title: "SecureRC: A System for Privacy-Preserving Relation Classification using Secure Multi-Party Computation", publication: "Computers & Security", year: "2019", authors: "C Gao, J Yu", deleted: false, createTime: Date(), updateTime: Date()),
        Paper(title: "Wolverine: A Scalable and Transaction-Consistent Redactable Permissionless Blockchain", publication: "IEEE Transactions on Information Forensics and Security", year: "2018", authors: "J Li, H Ma, J Wang, Z Song, W Xu, R Zhang", deleted: false, createTime: Date(), updateTime: Date()),
        Paper(title: "MWPoW+: a strong consensus protocol for intra-shard consensus in blockchain sharding", publication: "ACM Transactions on Internet Technology", year: "2021", authors: "Y Xu, J Shao, T Slaats, B Düdder", deleted: false, createTime: Date(), updateTime: Date()),
        Paper(title: "Smart Contracts in Blockchain Technology: A Critical Review", publication: "Information", year: "2022", authors: "H Taherdoost", deleted: false, createTime: Date(), updateTime: Date()),
        Paper(title: "Security and Privacy in Connected Vehicle Cyber Physical System Using Zero Knowledge Succinct Non Interactive Argument of Knowledge over Blockchain", publication: "Applied Sciences", year: "2022", authors: "R Khan, A Mehmood, Z Iqbal, C Maple, G Epiphaniou", deleted: false, createTime: Date(), updateTime: Date())
    ]
    
    static var previews: some View {
        PapersView(papers: papers, category: "Preview")
    }
}
