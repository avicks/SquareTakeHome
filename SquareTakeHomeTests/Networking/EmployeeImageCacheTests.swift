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
    
    func testSetupCache() {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            XCTFail("Unable to locate cache directory")
            return
        }
        
        let url = directory.appendingPathExtension("/employee_images")
        employeeImageCache.setupCache()
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }
    
    func testClearCache() {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            XCTFail("Unable to locate cache directory")
            return
        }
        
        let url = directory.appendingPathExtension("/employee_images")
        employeeImageCache.setupCache()
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
        
        employeeImageCache.clearCache()
        XCTAssertFalse(FileManager.default.fileExists(atPath: url.path))
    }
    
    func testStoreImage() {
        employeeImageCache.clearCache()
    }

    func testImageCache() {
        employeeImageCache.setupCache()
        // Assert our cache is empty
        let imagePath = "soccer"
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
