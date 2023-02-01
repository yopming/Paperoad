//
//  PaperAddView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    @State var isPaperAddViewPresented: Bool
    
    @State private var title = ""
    
    var body: some View {
        VStack {
            Text("New Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Form {
                TextField("Title", text: $title)
            }
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) { isPaperAddViewPresented = false }
                Button("Create") {
                    isPaperAddViewPresented = false
                }
                .disabled(title.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 550, alignment: .leading)
    }
}
