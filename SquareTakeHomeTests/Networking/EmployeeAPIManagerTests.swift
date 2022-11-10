//
//  EmployeeAPIManagerTests.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/10/22.
//

import XCTest
@testable import SquareTakeHome

class EmployeeAPIManagerTests: XCTestCase {
    func testFetchEmployeesSuccess() {
        let manager = MockEmployeeAPIManager(withMockType: .success)
        manager.fetchEmployees { result in
            switch result {
            case .success(let employees):
                XCTAssertEqual(employees.count, 1)
            case .failure(_):
                XCTFail("testFetchEmployeeSuccess should not fail!")
            }
        }
    }
    
    func testFetchEmployeeEmpty() {
        let manager = MockEmployeeAPIManager(withMockType: .empty)
        manager.fetchEmployees { result in
            switch result {
            case .success(let employees):
                XCTAssertEqual(employees.count, 0)
            case .failure(_):
                XCTFail("testFetchEmployeeEmpty should not fail!")
            }
        }
    }
    
    func testFetchEmployeeMalformed() {
        let manager = MockEmployeeAPIManager(withMockType: .malformed)
        manager.fetchEmployees { result in
            switch result {
            case .success(_):
                XCTFail("testFetchEmployeeMalformed should not succeed!")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
