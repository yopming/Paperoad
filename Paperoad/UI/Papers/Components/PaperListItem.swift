//
//  PaperListItem.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import SwiftUI

struct PaperListItem: View {
    let paper: Paper
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("\(paper.id ?? 0). \(paper.title)")
                .fontWeight(.bold)
                .font(.headline)
                .padding([.bottom], 1)
                .padding([.top], -4)
            Text("\(paper.authors ?? "")")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                Text("\(paper.year ?? "")")
                    .fontWeight(.semibold)
                    .font(.footnote)
                Text("\(paper.publication ?? "")")
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
    }
}
