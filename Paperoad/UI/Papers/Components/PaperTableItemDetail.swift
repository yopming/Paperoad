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
        TabView {
            // Tab
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    SwiftUI.Group {
                        Text(paper.title)
                            .padding([.top], 15)
                            .padding([.bottom], 25)
                            .font(.headline)
                        item(title: "Type", content: String(paper.type ?? Int16()))
                        
                        item(title: "Publication", content: paper.publication)
                        item(title: "Year", content: paper.year)
                    }
                    
                    SwiftUI.Group {
                        item(title: "Authors", content: paper.authors)
                        item(title: "Publisher", content: paper.publisher)
                        item(title: "Number", content: paper.number)
                        item(title: "Volume", content: paper.volume)
                        item(title: "Pages", content: paper.pages)
                        item(title: "URL", content: paper.url)
                    }
                    
                    SwiftUI.Group {
                        item(title: "DOI", content: paper.doi)
                        item(title: "ISBN", content: paper.isbn)
                        item(title: "arXiv", content: paper.arxiv)
                    }
                    
                    SwiftUI.Group {
                        item(title: "Create Time", content: paper.createTime.formatted())
                        item(title: "Update Time", content: paper.updateTime.formatted())
                    }
                }
                .padding([.horizontal], 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .tabItem { Text("Info") }
            
            // Tab
            ScrollView {
                Text(paper.abstract ?? "")
                    .multilineTextAlignment(.leading)
                    .padding(7)
            }
            .tabItem{ Text("Abstract") }
            
            // Tab
            ScrollView {
                Text(paper.note ?? "")
                    .multilineTextAlignment(.leading)
                    .padding(7)
            }
            .tabItem { Text("Notes") }
        }
    }
    
    @ViewBuilder
    func item(title: String, content: String?) -> some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.caption)
                .opacity(0.5)
            Spacer()
            Text(content ?? "")
                .multilineTextAlignment(.trailing)
        }
        Divider()
            .padding([.horizontal], 0)
            .padding([.vertical], 5)
    }
}
