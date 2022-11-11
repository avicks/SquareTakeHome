//
//  URL+Extension.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import Foundation

extension URL {
    var asCacheKey : NSString {
        return self.absoluteString as NSString
    }
}
