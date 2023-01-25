//
//  AppStateWrapper.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Combine
import SwiftUI

class StateWrapper<T: Equatable> {
    private var _state: T
    private var _lastState: T
    
    var value: T {
        get {
            return self._state
        }
        set {
            self._state = newValue
            if newValue != self._lastState {
                self._lastState = newValue
                self.publisher.send(newValue)
            }
        }
    }
    
    var binding: Binding<T> {
        Binding<T> (
            get: {
                return self._state
            },
            set: {
                self._state = $0
                if $0 != self._lastState {
                    self._lastState = $0
                    self.publisher.send($0)
                }
            }
        )
    }
    let publisher: CurrentValueSubject<T, Never>
    
    init(_ initState: T) {
        _state = initState
        _lastState = initState
        self.publisher = CurrentValueSubject<T, Never>(_state)
    }
}
