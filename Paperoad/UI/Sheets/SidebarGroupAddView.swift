//
//  SidebarGroupAddView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import SwiftUI

struct SidebarGroupAddView: View {
    // keep track of if the sheet should be shown
    @Binding var isPresented: Bool
    
    @State private var groupName = ""
    @State private var groupDescription = ""
    
    // the name of the sheet
    var title: String = "New Group"
    
    // called when the sheet is done
//    var onFinish: (_ name: String, _ description: String) -> () {
//    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Form {
                TextField("* Name:", text: $groupName)
                TextField("Description", text: $groupDescription)
            }
            Divider()
            HStack {
                Button("Close", role: .cancel) { isPresented = false }
                Button("Create") { isPresented = false }
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

