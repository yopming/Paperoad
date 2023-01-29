//
//  SidebarGroupAddView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import SwiftUI
import RealmSwift

struct SidebarGroupAddView: View {
    // keep track of if the sheet should be shown
    @Binding var isPresented: Bool
    
    @ObservedRealmObject var group: GroupModel
    
    // the name of the sheet
    var title: String = "New Group"
    
    // called when the sheet is done
    var onFinish: (String) -> ()
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Form {
                TextField("Name:", text: $group.name)
            }
            Divider()
            HStack {
                Button("Close", role: .cancel) { isPresented = false }
                Button("Create") {
                    onFinish(group.name)
                    isPresented = false
                }
                .disabled(group.name.isEmpty)
                .tint(.accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 300, alignment: .leading)
    }
}
