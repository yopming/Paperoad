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
    @State private var publicationType = 0
    @State private var publication = ""
    @State private var publisher = ""
    @State private var year = ""
    @State private var volume = ""
    @State private var pages = ""
    @State private var number = ""
    @State private var arxiv = ""
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
                
                Spacer(minLength: CGFloat(15))
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
                    
                    TextField("Volume", text: $volume)
                    TextField("Pages", text: $pages)
                    TextField("Number", text: $number)
                    TextField("Publisher", text: $publisher)
                    TextField("arXiv ID", text: $arxiv)
                    TextField("DOI", text: $doi)
                    TextField("URL", text: $url)
                }
                
                Picker("Group", selection: $selectedGroup) {
                    ForEach(0..<groups.count, id: \.self) { index in
                        Text(self.groups[index].name!)
                    }
                }
                
                Spacer(minLength: CGFloat(25))
                Section(header: Text("Note")) {
                    TextEditor(text: $note)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary).opacity(0.5))
                }
            }
            Text("New paper will be shown in group 'Unfiled'.")
            
            Divider()
            HStack {
                Button("Close", role: .cancel) { isPaperAddViewPresented = false }
                Button("Create") {
                    isPaperAddViewPresented = false
                    addPaper(title: title, authors: authors, publicationType: Int16(publicationType), publication: publication, publisher: publisher, year: year, volume: volume, pages: pages, number: number, arxiv: arxiv, doi: doi, url: url, note: note)
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
