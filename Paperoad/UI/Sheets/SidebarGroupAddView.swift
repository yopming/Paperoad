//
//  SidebarGroupAddView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import SwiftUI

struct SidebarGroupAddView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    // keep track of if the sheet should be shown
    @Binding var showSheet: SidebarSheetView?
    
    @State private var groupName = ""
    
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
                    showSheet = nil
                    addGroup(name: groupName)
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

