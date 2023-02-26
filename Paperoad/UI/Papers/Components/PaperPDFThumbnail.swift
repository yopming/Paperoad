//
//  PaperPDFThumbnail.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/25/23.
//

import SwiftUI
import PDFKit

struct PaperPDFThumbnail: NSViewRepresentable {
    @Default(\.storageDir) var storageDir
    
    let url: URL
    
    func makeNSView(context: Context) -> PDFThumbnailView {
        let pdfView = PDFView()
        
        if let storageUrl = restoreFileAccess(with: storageDir) {
            _ = storageUrl.startAccessingSecurityScopedResource()
            pdfView.document = PDFDocument(url: url)
            storageUrl.stopAccessingSecurityScopedResource()
        }
        
        pdfView.displayMode = .singlePageContinuous
        
        let thumbnail = PDFThumbnailView()
        thumbnail.pdfView = pdfView
        thumbnail.thumbnailSize = CGSize(width: 150, height: 250)
        return thumbnail
    }
    
    func updateNSView(_ pdfView: PDFThumbnailView, context: Context) {
        pdfView.pdfView?.document = PDFDocument(url: url)
    }
}
