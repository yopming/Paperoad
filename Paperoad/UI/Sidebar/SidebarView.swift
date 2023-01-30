//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarView: View {
    // which group or tag is selected right now, for router
//    @State private var selectedGroup: Int?
    
    var body: some View {
        List {
            SidebarGroupView(viewModel: GroupViewModel(database: AppDatabase.shared))
            // TODO: tag implementation
            // SidebarTagView()
        }
        // SidebarActionView() at the very bottom
        .safeAreaInset(edge: .bottom) {
            SidebarActionView()
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth:100, idealWidth: 200)
    }
}
