//
//  ReuseIdentifying.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
