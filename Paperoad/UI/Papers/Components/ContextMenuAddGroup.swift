//
//  ContextMenuAddGroup.swift
//  Paperoad
//
//  Created by Tieming on 2/10/23.
//

import SwiftUI
import GRDBQuery

/// This context menu only shows in unfiled and each grop, not in "All papers" and "Trashed Papers".
/// Since the selected paper in "All papers" and "Trashed papers" may be from different group.
/// This cause inconsistent check in this context menu.
/// Right now, only show when selectedPapers.size == 1, and one paper should have only one group.
struct PapersContextMenuAddGroup: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @Query(GroupRequest(), in: \.appDatabase) private var groups: [Group]
    @Query(PaperGroupRequest(), in: \.appDatabase) private var paperGroups: [PaperGroup]
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    let paperId: Int64
    
    var body: some View {
        Menu("Move to Group") {
            ForEach(groups) { group in
                if getGroupId(paperId: paperId) == group.id {
                    Button("\(group.name)") {}
                        .disabled(true)
                } else {
                    Button("\(group.name)") {
                        save(paperId: paperId, groupId: group.id!)
                    }
                }
            }
        }
    }
    
    // return the groupId of given paperIds, all these papers should be in same group.
    private func getGroupId(paperId: Int64) -> Int64? {
        var groupId: Int64?
        for pair in paperGroups {
            if pair.paperId == paperId {
                groupId = pair.groupId
                break
            }
        }
        
        return groupId
    }
    
    private func save(paperId: Int64, groupId: Int64) {
        do {
            var paperGroup = try appDatabase.readPaperGroupByPaper(paperId: paperId)
            if paperGroup == nil {
                paperGroup = PaperGroup(paperId: paperId, groupId: groupId)
            } else {
                paperGroup!.groupId = groupId
            }
            
            try appDatabase.savePaperGroup(&paperGroup!)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Add to Group Error occurred"
        }
    }
}
