//
//  EmployeeImageCache.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import UIKit

struct EmployeeImageCache {
    
    static let shared = EmployeeImageCache()
    
    private var cache: NSCache<NSString, UIImage>
    
    public init() {
        cache = NSCache()
    }
    
    func store(image: UIImage, forKey key: NSString) {
        self.cache.setObject(image, forKey: key)
    }
    
    func getImage(forKey key: NSString) -> UIImage? {
        return self.cache.object(forKey: key)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
