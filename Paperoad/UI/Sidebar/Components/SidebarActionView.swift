//
//  SidebarActionView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarActionView: View {
    // if AddGroup sheet is presented
    @State private var isAddGroupFormIsPresented: Bool = false
    
    @State private var name: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Divider()
            Button(
                action: openNewGroupFormView,
                label: {
                    Label("New Group", systemImage: "plus")
                }
            )
            
            // add popover window for new group
            .sheet(
                isPresented: $isAddGroupFormIsPresented,
                onDismiss: {
                    // refresh group list after adding
                },
                content: {
                    SidebarGroupAddView(
                        isPresented: $isAddGroupFormIsPresented
                    )
                }
            )
        }
        .padding()
    }
}


// MARK: - Actions
extension SidebarActionView {
    func openNewGroupFormView() {
        isAddGroupFormIsPresented = true
    }
}
