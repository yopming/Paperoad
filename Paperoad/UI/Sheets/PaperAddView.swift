//
//  PaperAddView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    @Binding var isPresented: Bool
    
    let types = ["Book", "Conference Paper", "Journal Article", "WebPage"]
    internal var groups: FetchedResults<Group>
    
    @State private var title = ""
    @State private var selectedType = 0
    @State private var selectedGroup = 0
    
    var body: some View {
        VStack {
            Text("New Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Form {
                Picker("Group", selection: $selectedGroup) {
                    ForEach(0..<groups.count) {
                        Text(self.groups[$0].name!)
                    }
                }
                
                Picker("Type", selection: $selectedType) {
                    ForEach(0..<types.count) {
                        Text(self.types[$0])
                    }
                }
                TextField("Title", text: $title)
            }
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) { isPresented = false }
                Button("Create") {
                    isPresented = false
                }
                .disabled(title.isEmpty)
//                .tint(.accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 550, alignment: .leading)
    }
}
