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
                VStack(alignment: .leading, spacing: 20) {
                    SwiftUI.Group {
                        item(title: "Type", content: String(paper.type ?? Int16()))
                        item(title: "Title", content: paper.title)
                        item(title: "Abstract", content: paper.abstract)
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
                        item(title: "Group", content: String(paper.group ?? 0))
                    }
                    
                    SwiftUI.Group {
                        item(title: "Create Time", content: paper.createTime.description)
                        item(title: "Update Time", content: paper.updateTime.description)
                    }
                }
            }
            .tabItem { Text("Info") }
            
            // Tab
            ScrollView {
                Text(paper.note ?? "")
                    .multilineTextAlignment(.leading)
                    .lineLimit(10)
                    .padding()
            }
            .tabItem { Text("Notes") }
            
            // Tab
            ScrollView {
                item(title: "Attachment", content: paper.attachment)
            }
            .tabItem { Text("Attachments") }
        }
    }
    
    @ViewBuilder
    func item(title: String, content: String?) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.caption)
                .opacity(0.5)
            Text(content ?? "")
        }
    }
}
