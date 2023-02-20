//
//  PaperTableItemDetail.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/19/23.
//

import SwiftUI

struct PaperTableItemDetail: View {
    var paper: Paper
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(paper.title)
                    .font(.title)
                Text(paper.publication ?? "")
                Text(paper.year ?? "")
                Text(paper.authors ?? "")
                Text(paper.publisher ?? "")
            }
        }
    }
}
