//
//  URL+Extension.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import Foundation

extension URL {
    
    
    /// Assuming all image paths are uniform for this exercise,
    ///   return the image UUID in the path supplied by the URL
    var imageCacheKey : String {
        let pathComponents = self.pathComponents
        let key = "\(pathComponents[pathComponents.count - 2]).jpg"
        return key
    }
}
