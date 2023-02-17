//
//  AppStorage.swift
//  Paperoad
//
//  Created by Tieming on 2/16/23.
//

import SwiftUI
import Foundation

/// Wrapper for AppStorage.
/// In other Views, the property can be accessed by @Default(\.attr) var attr
public class Defaults: ObservableObject {
    @AppStorage("theme") public var theme = "Follow System"
    @AppStorage("reader") public var reader = "System"
    @AppStorage("storageDir") public var storageDir = ""
    
    public static let shared = Defaults()
}

@propertyWrapper
public struct Default<T>: DynamicProperty {
    @ObservedObject private var defaults: Defaults
    private let keyPath: ReferenceWritableKeyPath<Defaults, T>
    
    public init(_ keyPath: ReferenceWritableKeyPath<Defaults, T>, defaults: Defaults = .shared) {
        self.keyPath = keyPath
        self.defaults = defaults
    }
    
    public var wrappedValue: T {
        get { defaults[keyPath: keyPath] }
        nonmutating set { defaults[keyPath: keyPath] = newValue }
    }
    
    public var projectedValue: Binding<T> {
        Binding(
            get: { defaults[keyPath: keyPath] },
            set: { value in defaults[keyPath: keyPath] = value }
        )
    }
}
