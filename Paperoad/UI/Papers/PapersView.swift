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
    
    @EnvironmentObject var appState: AppState
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // which sheet to show in PapersView
    @State private var showSheet:PapersSheetView? = nil
    
    @State private var selectedPaperToUpdate: Paper?
    @State private var selectedPaperIds = Set<Paper.ID>()
    
    @State var sortOrder: [KeyPathComparator<Paper>] = [
        .init(\.title, order: SortOrder.forward)
    ]
    
    // for single selection:
    
    var papers: [Paper]
    // special string to indicate current destination
    var category: String
    
    var body: some View {
        // TODO alternative representation style with table instead of list
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                //            ScrollView(.horizontal) {
                Table(selection: $selectedPaperIds, sortOrder: $sortOrder) {
                    TableColumn("Title", value: \.title)
                        .width(min: 300)
                    
                    TableColumn("Authors") { paper in
                        Text(paper.authors ?? "" )
                    }
                    .width(min: 100, ideal: 50)
                    
                    TableColumn("Year") { paper in
                        Text(paper.year ?? "")
                    }
                    .width(35)
                    
                    TableColumn("Publication") { paper in
                        Text(paper.publication ?? "")
                    }
                    .width(min: 150, ideal: 100)
                } rows: {
                    ForEach(sortedPapers) { paper in
                        TableRow(paper)
                            .contextMenu {
                                PapersContextMenuAddGroup(paper: paper)
                                
                                if selectedPaperIds.count == 1 {
                                    Button("Update Paper") {
                                        selectedPaperToUpdate = selectedPaper
                                    }
                                }
                                
                                Button("Delete") { trash() }
                                
                                // TODO: put back and delete permanantely in Trash
                                
                                // For debug, print data of one paper in the list
                                Button("Console.log") { consoleLog() }
                            }
                    }
                }
                //            }
                
                // if seletedPaperIds.count == 1 will make PaperTableItemDetail
                // shows only when one paper is selected
                Divider()
                
                if let selectedPaper = selectedPaper {
                    PaperTableItemDetail(paper: selectedPaper)
                        .padding([.vertical], 10)
                        .padding([.horizontal], 10)
                        .frame(width: 300)
                } else {
                    Text("Select one paper for more details.")
                        .padding()
                        .frame(width: 300)
                }
            }
            
            .sheet (
                item: $selectedPaperToUpdate,
                onDismiss: {
                    // when update done, clear "selectedPaperIds"
                    selectedPaperIds.removeAll()
                },
                content: { paper in
                    PaperUpdateView(paper: paper)
                }
            )
            
            Divider()
            
            Text("\(selectedPaperIds.count) papers selected.")
                .padding()
        }
    }
    
    // papers after sorting to be renderred in table
    var sortedPapers: [Paper] {
        return papers.sorted(using: sortOrder)
    }
    
    // get selected one when multiple selections occur
    var selectedPaper: Paper? {
        guard let selectedPaperId = selectedPaperIds.first else { return nil }
        let selectedPaper = papers.first {
            $0.id == selectedPaperId
        }
        return selectedPaper
    }
     
    private func trash() {
        while !selectedPaperIds.isEmpty {
            // get first paper in selected papers
            guard let paperId = selectedPaperIds.popFirst() else { return }
            guard var paper = papers.first(where: { $0.id == paperId }) else { return }
            
            // update the paper's 'deleted' and 'updateTime'
            paper.deleted = true
            paper.updateTime = Date()
            do {
                try appDatabase.savePaper(&paper)
            } catch {
                errorAlertIsPresented = true
                errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Trash Paper error occurred"
            }
        }
    }

    private func consoleLog() {
        print(selectedPaper ?? "No paper selected")
    }
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
