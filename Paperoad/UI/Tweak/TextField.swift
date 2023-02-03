//
//  TextField.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import SwiftUI

struct TextFieldVertical: View {
    var inputLabel: String = ""
    @Binding var inputBinding: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(inputLabel)")
                .padding([.leading], 18)
                .padding([.bottom], -5)
            TextField("", text: $inputBinding)
        }
    }
    
    public init(label: String, binding: Binding<String>) {
        self.inputLabel = label
        self._inputBinding = binding
    }
}
