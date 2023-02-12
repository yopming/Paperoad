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
//    let papersInGroup: [Paper]
    
    @Query(PaperRequest(), in: \.appDatabase) private var papers: [Paper]
    @Query(PaperAllRequest(), in: \.appDatabase) private var allPapers: [Paper]
    @Query(PaperTrashedRequest(), in: \.appDatabase) private var trashedPapers: [Paper]
    @Query(PaperTrashedRequest(), in: \.appDatabase) private var unfiledPapers: [Paper]
    
    init(group: String) {
        self.groupName = group
        self.groupId = 0
    }
    
    init(groupName: String, groupId: Int64) {
        self.groupName = groupName
        self.groupId = groupId
        
        do {
            let pairs: [PaperGroup] = try appDatabase.readPaperGroupsByGroup(groupId: groupId)
            let paperIds = pairs.map { $0.paperId }
            print(paperIds)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "readPaperGroupsByGroup() error occurred"
        }
    }
    
    var body: some View {
        switch groupName {
        case ".all":
            PapersView(papers: papers)
        case ".unfiled":
            PapersView(papers: unfiledPapers)
        case ".trash":
            PapersView(papers: trashedPapers)
        case ".allwithtrash":
            PapersView(papers: allPapers)
        default:
            PapersView(papers: papers)
        }
    }
}
