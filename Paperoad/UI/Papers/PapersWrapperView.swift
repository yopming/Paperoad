//
//  PapersWrapperView.swift
//  Paperoad
//
//  Created by Tieming on 2/8/23.
//

import SwiftUI
import GRDBQuery

struct PapersWrapperView: View {
    let group: String
    
    
    @Query(PaperRequest(), in: \.appDatabase) private var papers: [Paper]
    @Query(PaperAllRequest(), in: \.appDatabase) private var allPapers: [Paper]
    @Query(PaperTrashedRequest(), in: \.appDatabase) private var trashedPapers: [Paper]
    @Query(PaperTrashedRequest(), in: \.appDatabase) private var unfiledPapers: [Paper]
    
    var body: some View {
        PapersView(papers: allPapers)
    }
}
