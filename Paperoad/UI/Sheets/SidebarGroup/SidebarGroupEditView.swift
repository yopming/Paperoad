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

    @State var groupName = ""
    @State var group: Group
    
    var body: some View {
        let groupNameBinding = Binding(
            get: { self.groupName },
            set: { self.groupName = $0 }
        )

        VStack {
            Text("Rename Group")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            Form {
                TextField("Name:", text: groupNameBinding)
            }

            Divider()

            HStack {
                Button("Close", role: .cancel) {
                    dismiss()
                }
                Button("Update") {
                    update(name: groupNameBinding.wrappedValue)
                    dismiss()
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
    
    private func update(name: String) {
        do {
            group.name = name
            try appDatabase.saveGroup(&group)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Update Group error occurred"
        }
    }
}
