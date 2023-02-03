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
    @State private var publicationType = 0
    @State private var volumn = ""
    @State private var pages = ""
    @State private var number = ""
    @State private var publisher = ""
    @State private var arvix = ""
    @State private var doi = ""
    @State private var url = ""
    @State private var note = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("New Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
            
            Form {
                TextField("Title", text: $title)
                TextField("Authors", text: $authors)
                
                Section(header: Text("Publication")) {
                    TextField("Publication", text: $publication)
                    TextField("Publication Year", text: $year)
                    Picker("Publication Type", selection: $publicationType) {
                        ForEach(0..<paperIdTypes.count, id: \.self) { index in
                            Text(self.paperIdTypes[index])
                        }
                    }
                    .fixedSize()
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Volume", text: $volumn)
                    TextField("Pages", text: $pages)
                    TextField("Number", text: $number)
                    TextField("Publisher", text: $publisher)
                    TextField("arXiv ID", text: $arvix)
                    TextField("DOI", text: $doi)
                }
                
                Picker("Group", selection: $selectedGroup) {
                    ForEach(0..<groups.count, id: \.self) { index in
                        Text(self.groups[index].name!)
                    }
                }
                
                TextField("Note",  text: $note, axis: .vertical)
            }
            Text("New paper will be shown in group 'Unfiled'.")
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) { isPaperAddViewPresented = false }
                Button("Create") {
                    isPaperAddViewPresented = false
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
