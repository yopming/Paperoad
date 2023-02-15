//
//  SidebarUploadView.swift
//  Paperoad
//
//  Created by Tieming on 2/14/23.
//

import SwiftUI

struct SidebarUploadView: View {
    @State var image = NSImage(named: "image")
    @State private var dragOver = false
    
    var body: some View {
        GroupBox() {
            Text("Drag Here to Upload")
                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .center)
        }
        .padding()
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SidebarUploadView()
    }
}
