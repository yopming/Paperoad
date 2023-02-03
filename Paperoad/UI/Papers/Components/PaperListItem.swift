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
        VStack (alignment: .leading, spacing: 0) {
            Text("\(title)")
                .fontWeight(.bold)
                .font(.headline)
                .padding([.bottom], 1)
                .padding([.top], -4)
            Text("\(authors)")
                .font(.caption)
                .foregroundColor(.gray)
            Text("\(year) | \(publication)")
                .font(.footnote)
        }
    }
}
