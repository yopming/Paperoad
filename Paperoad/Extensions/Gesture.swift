//
//  Gesture.swift
//  Paperoad
//
//  Created by Tieming on 2/17/23.
//

import SwiftUI
import Foundation

var tapGesture: some Gesture {
    TapGesture(count: 2)
        .onEnded {
            print("double tap")
        }
        .simultaneously(with: TapGesture(count: 1)
            .onEnded {
                print("single tap")
            }
        )
}
