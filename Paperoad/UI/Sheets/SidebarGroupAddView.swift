//
//  SidebarGroupAddView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import SwiftUI

struct SidebarGroupAddView: View {
    // keep track of if the sheet should be shown
    @Binding var showSheet: SidebarSheetView?
    
    @State private var groupName = ""
    
    let viewModel = GroupListViewModel(database: AppDatabase.persistence)
    
    var body: some View {
        VStack {
            Text("New Group")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Form {
                TextField("Name:", text: $groupName)
            }
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) {
                    showSheet = nil
                }
                Button("Create") {
                    viewModel.insertGroup(groupName)
                    showSheet = nil
                }
                    .disabled(groupName.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .tint(groupName.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 350, alignment: .leading)
    }
}

