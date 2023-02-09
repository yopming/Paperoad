//
//  PaperUpdateView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/5/23.
//

import SwiftUI
import GRDBQuery

struct PaperUpdateView: View {
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    
    @Query(GroupRequest(), in: \.appDatabase) private var groups: [Group]
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    @State var paper: Paper
    
    // fetch paper id types
    let paperIdTypes: [String] = PaperConfig.IdTypes.allCases.map { $0.rawValue }
    
    var body: some View {
        let titleBinding = Binding(get: {self.paper.title}, set: {self.paper.title = $0})
        let publicationBinding = Binding(get: {self.paper.publication ?? ""}, set: {self.paper.publication = $0})
        let yearBinding = Binding(get: {self.paper.year ?? ""}, set: {self.paper.year = $0})
        let authorsBinding = Binding(get: {self.paper.authors ?? ""}, set: {self.paper.authors = $0})
        let publisherBinding = Binding(get: {self.paper.publisher ?? ""}, set: {self.paper.publisher = $0})
        let doiBinding = Binding(get: {self.paper.doi ?? ""}, set: {self.paper.doi = $0})
        let isbnBinding = Binding(get: {self.paper.isbn ?? ""}, set: {self.paper.isbn = $0})
        let arxivBinding = Binding(get: {self.paper.arxiv ?? ""}, set: {self.paper.arxiv = $0})
        let abstractBinding = Binding(get: {self.paper.abstract ?? ""}, set: {self.paper.abstract = $0})
        let noteBinding = Binding(get: {self.paper.note ?? ""}, set: {self.paper.note = $0})
        let numberBinding = Binding(get: {self.paper.number ?? ""}, set: {self.paper.number = $0})
        let volumeBinding = Binding(get: {self.paper.volume ?? ""}, set: {self.paper.volume = $0})
        let pagesBinding = Binding(get: {self.paper.pages ?? ""}, set: {self.paper.pages = $0})
        let urlBinding = Binding(get: {self.paper.url ?? ""}, set: {self.paper.url = $0})
        
        let typeBinding = Binding(get: {Int(self.paper.type ?? 0)}, set: {self.paper.type = Int16($0)})
        let groupBinding = Binding(
            get: {Int(self.paper.group ?? 0)},
            set: {self.paper.group = Int64($0)}
        )
        
        VStack(spacing: 20) {
            Text("Update Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
            
            Form {
                TextField("Title", text: titleBinding, prompt: Text("Required"))
                TextField("Authors", text: authorsBinding)
                
                Spacer(minLength: CGFloat(25))
                Section(header: Text("Abstract")) {
                    TextEditor(text: abstractBinding)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary)
                                .opacity(0.5)
                        )
                }
                Spacer(minLength: CGFloat(15))

                SwiftUI.Group {
                    TextField("Publication", text: publicationBinding)
                    TextField("Publication Year", text: yearBinding)

                    Picker("Publication Type", selection: typeBinding) {
                        ForEach(0..<paperIdTypes.count, id: \.self) {
                            Text(paperIdTypes[$0]).tag(Optional($0))
                        }
                    }
                    .fixedSize()
                    .pickerStyle(SegmentedPickerStyle())
                
                    TextField("Volume", text: volumeBinding)
                    TextField("Pages", text: pagesBinding)
                    TextField("Number", text: numberBinding)
                    TextField("Publisher", text: publisherBinding)
                }

                SwiftUI.Group {
                    TextField("arXiv ID", text: arxivBinding)
                    TextField("DOI", text: doiBinding)
                    TextField("ISBN", text: isbnBinding)
                    TextField("URL", text: urlBinding)
                }

                Spacer(minLength: CGFloat(25))
                Section(header: Text("Note")) {
                    TextEditor(text: noteBinding)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary)
                                .opacity(0.5)
                        )
                }
            }
            
            Divider()
            HStack {
                Button("Close", role: .cancel) {
                    dismiss()
                }
                
                Button("Update") {
                    dismiss()
                    update()
                }
                .disabled(paper.title.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(paper.title.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 650, alignment: .leading)
    }
    
    private func update() {
        do {
            paper.updateTime = Date()
            try appDatabase.savePaper(&paper)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Update Paper error occurred"
        }
    }
}
