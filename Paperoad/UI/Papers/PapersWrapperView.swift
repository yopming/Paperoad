//
//  PapersWrapperView.swift
//  Paperoad
//
//  Created by Tieming on 2/8/23.
//

import SwiftUI
import GRDBQuery

struct PapersWrapperView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    let groupName: String
    let groupId: Int64?
    
    @Query(PaperRequest(), in: \.appDatabase) private var papers: [Paper]
    @Query(PaperTrashedRequest(), in: \.appDatabase) private var trashedPapers: [Paper]
    @Query(PaperUnfiledRequest(), in: \.appDatabase) private var unfiledPapers: [Paper]
    
    init(group: String) {
        self.groupName = group
        self.groupId = 0
    }
    
    init(groupName: String, groupId: Int64) {
        self.groupName = groupName
        self.groupId = groupId
    }
    
    var body: some View {
        switch groupName {
        case ".all":
            PapersView(papers: papers, category: ".all")
        case ".unfiled":
            PapersView(papers: unfiledPapers, category: ".unfiled")
        case ".trash":
            PapersView(papers: trashedPapers, category: ".trash")
        default:
            PapersView(papers: filterByGroup(papers, self.groupId!), category: ".default")
        }
    }
    
    private func filterByGroup(_ papers: [Paper], _ groupId: Int64) -> [Paper] {
        let results = papers.filter { paper in
            return paper.group == groupId
        }
        return results
    }
}

// enum for sheets in PapersView
enum PapersSheetView: Identifiable {
    var id: Self { self }
    case update, delete
}
