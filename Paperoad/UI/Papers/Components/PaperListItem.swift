//
//  PaperListItem.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import SwiftUI

struct PaperListItem: View {
    let title: String
    let authors: String
    let year: String
    let publication: String
    
    var body: some View {
        Text("\(title)")
            .fontWeight(.bold)
            .font(.title)
    }
}
