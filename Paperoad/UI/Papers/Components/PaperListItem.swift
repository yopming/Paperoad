//
//  PaperListItem.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import SwiftUI
import GRDBQuery

struct PaperListItem: View {
    @Environment(\.appDatabase) private var appDatabase
    @Query(GroupRequest(), in: \.appDatabase) private var groups: [Group]
    
    let paper: Paper
    let category: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            title()
                .fontWeight(.bold)
                .font(.headline)
                .padding([.bottom], 1)
                .padding([.top], -4)
            Text("\(paper.authors ?? "")")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                Text("\(paper.year ?? "")")
                    .fontWeight(.semibold)
                    .font(.footnote)
                Text("\(paper.publication ?? "")")
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
    }
    
    @ViewBuilder
    func title() -> some View {
        if category == ".all" || category == ".trash" {
            let groupName = getGroupNameById(paper.group)
            HStack(spacing: 10) {
                if groupName != "" && groupName != nil {
                    Text("\(groupName!)")
                        .padding([.horizontal], 5)
                        .background(.gray.opacity(0.4))
                        .clipShape(Capsule())
                }
                Text("\(paper.title)")
            }
        } else {
            Text("\(paper.title)")
        }
    }
    
    private func getGroupNameById(_ groupId: Int64?) -> String? {
        var groupName: String?
        for group in groups {
            if group.id == groupId {
                groupName = group.name
                break
            }
        }
        return groupName
    }
}
