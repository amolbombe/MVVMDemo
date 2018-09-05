//
//  Box.swift
//  MVVMDemoApp
//
//  Created by Amol Bombe on 05/09/18.
//  Copyright © 2018 Amol. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
