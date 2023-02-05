//
//  PaperAddView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    // fetch relation "Group"
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Group.name, ascending: false)],
        animation: .default
    ) internal var groups: FetchedResults<Group>
    
    // fetch paper id types
    let paperIdTypes: [String] = PaperConfig.IdTypes.allCases.map { $0.rawValue }
    
    @Binding var isPaperAddViewPresented: Bool
    
    @State private var selectedGroup = 0
    
    @State private var title = ""
    @State private var authors = ""
    @State private var publication = ""
    @State private var year = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("New Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Form {
                TextField("Title", text: $title, prompt: Text("Required"))
                TextField("Authors", text: $authors)
                
                TextField("Publication", text: $publication)
                TextField("Publication Year", text: $year)
                
                Picker("Group", selection: $selectedGroup) {
                    ForEach(0..<groups.count, id: \.self) { index in
                        Text(self.groups[index].name!)
                    }
                }
                
            }
            Text("New paper will be shown in group 'Unfiled'. More details can be updated later.")
                .font(.footnote)
            
            Divider()
            HStack {
                Button("Random") {
                    isPaperAddViewPresented = false
                    addRandomPaper()
                }
                Button("Close", role: .cancel) {
                    isPaperAddViewPresented = false
                    print(groups[selectedGroup].name ?? "")
                }
                Button("Create") {
                    isPaperAddViewPresented = false
                    addPaper(
                        title: title,
                        authors: authors,
                        publication: publication,
                        year: year,
                        group: groups[selectedGroup].name ?? ""
                    )
                }
                .disabled(title.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(title.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 650, alignment: .leading)
    }
}
