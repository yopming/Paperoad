//
//  PaperAddView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddView: View {
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    // fetch paper id types
    let paperIdTypes: [String] = PaperIdTypes.allCases.map { $0.rawValue }
    
    @Binding var presented: Bool
    
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
            }
            Text("New paper will be shown in group 'Unfiled', more details can be updated later.")
            
            Divider()
            HStack {
                Button("Random") {
                    presented = false
                    random()
                }
                Button("Close", role: .cancel) {
                    presented = false
                }
                Button("Create") {
                    presented = false
                    save(title: title, pub: publication, year: year, authors: authors)
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
    
    private func save(title: String, pub: String?, year: String?, authors: String?) {
        do {
            var paper = Paper.new(title: title, pub: pub, year: year, authors: authors)
            try appDatabase.savePaper(&paper)
            dismiss()
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Paper add error occured."
        }
    }
    
    private func random() {
        do {
            var paper = Paper.random()
            try appDatabase.savePaper(&paper)
            dismiss()
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Paper add error occured."
        }
    }
}
