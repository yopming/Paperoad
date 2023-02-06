//
//  PaperUpdateView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/5/23.
//

import SwiftUI

struct PaperUpdateView: View {
    // fetch paper id types
    let paperIdTypes: [String] = PaperConfig.IdTypes.allCases.map { $0.rawValue }

    // keep track of if the sheet should be shown
    @Binding var showSheet: PapersSheetView?

    var body: some View {
        VStack(spacing: 20) {
            Text("Update Paper")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            Divider()

            Form {
//                TextField("Title", text: paper.title?, prompt: Text("Required"))
            }
            Text("New paper will be shown in group 'Unfiled'.")

            Divider()
            HStack {
                Button("Close", role: .cancel) {
                    showSheet = nil
                }
                Button("Create") {
                    showSheet = nil
                }
//                .disabled(self.updatePaper.title!.isEmpty)
                .buttonStyle(.borderedProminent)
//                .tint(self.updatePaper.title!.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 650, alignment: .leading)
    }
}
