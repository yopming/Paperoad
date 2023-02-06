//
//  SidebarGroupEditView.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import SwiftUI

struct SidebarGroupEditView: View {
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // keep track of if the sheet should be shown
    @Binding var showSheet: SidebarSheetView?
    
    @State private var groupName = ""
    private let group: Group
    
    var body: some View {
        VStack {
            Text("Rename Group")
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
                    dismiss()
                }
                Button("Update") {
                    showSheet = nil
                    update(name: groupName, group: group)
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
    
    private func update(name: String, group: Group) {
        
    }
}
