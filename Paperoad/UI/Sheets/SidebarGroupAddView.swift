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
    @Binding var isPresented: Bool
    
    @State private var groupName = ""
    
    // the name of the sheet
    var title: String = "New Group"
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Form {
                TextField("Name:", text: $groupName)
            }
            Divider()
            HStack {
                Button("Close", role: .cancel) { isPresented = false }
                Button("Create") {
                    isPresented = false
                    addGroup(name: groupName)
                }
                    .disabled(groupName.isEmpty)
                    .tint(.accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 300, alignment: .leading)
    }
}

