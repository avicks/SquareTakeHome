//
//  EmployeeImageCacheTests.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/10/22.
//

import XCTest
@testable import SquareTakeHome

class EmployeeImageCacheTests: XCTestCase {
    private let employeeImageCache: EmployeeImageCache = {
       return EmployeeImageCache()
    }()

    func testImageCache() {
        // Assert our cache is empty
        let imagePath = NSString(string: "soccer")
        var image = employeeImageCache.getImage(forKey: imagePath)
        XCTAssertNil(image)
        
        // Add an item to the cache. It now exists and is accessible
        self.employeeImageCache.store(image: UIImage(named: String(describing: imagePath))!, forKey: imagePath)
        image = employeeImageCache.getImage(forKey: imagePath)
        XCTAssertNotNil(image)
        
        // Clear the cache, again assert its empty
        employeeImageCache.clearCache()
        image = employeeImageCache.getImage(forKey: imagePath)
        XCTAssertNil(image)
    }
}
