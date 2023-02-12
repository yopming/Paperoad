//
//  PaperListItem.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import SwiftUI

struct PaperListItem: View {
    let id: Int64
    let title: String
    let authors: String
    let year: String
    let publication: String
    let deleted: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("\(title), \(id)")
                .fontWeight(.bold)
                .font(.headline)
                .padding([.bottom], 1)
                .padding([.top], -4)
            Text("\(authors)")
                .font(.caption)
                .foregroundColor(.gray)
            if deleted {
                Text("--Deleted")
            } else {
                Text("--")
            }
            HStack {
                Text("\(year) ")
                    .fontWeight(.semibold)
                    .font(.footnote)
                Text("\(publication)")
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
    }
}
