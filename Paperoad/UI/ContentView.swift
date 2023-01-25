//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State private var colorTheme: String?
    
    var body: some View {
        MainView()
            .frame(minWidth: 1000, minHeight: 800)
            .preferredColorScheme(colorScheme())
            .onReceive(colorSchemeUpdate, perform: {
                self.colorTheme = $0
            })
    }
    
    func colorScheme() -> ColorScheme? {
        switch colorTheme {
        case "System Default": return nil
        case "Light": return ColorScheme.light
        case "Dark": return ColorScheme.dark
        default:
            return nil
        }
    }
    
    var colorSchemeUpdate: AnyPublisher<String, Never> {
        UserDefaults.standard.publisher(for: \.preferColorTheme).eraseToAnyPublisher()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
