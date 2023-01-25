//
//  SearchBar.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

enum SearchMode {
    case general
    case fulltext
    case advanced
}

struct SearchBar: View {
    @Binding var text: String
    
    @State var searchMode: SearchMode = .general
    @State var searchModeIcon: String = "magnifyingglass"
    @State var searchModeText: String = "Search..."
    @State var isHelpShown: Bool = false
    
    var body: some View {
        HStack {
            Button (
                action: {
                },
                label: {
                    Image(systemName: searchModeIcon)
                }
            )
            .buttonStyle(PlainButtonStyle())
            .help(
                Text(isHelpShown ? """
                     Help text
                     """ : "")
            )
            
            TextField(searchModeText, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 300)
                .multilineTextAlignment(.leading)
        }.padding(.leading, 5)
    }
}
