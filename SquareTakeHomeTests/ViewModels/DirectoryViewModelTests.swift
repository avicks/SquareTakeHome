//
//  DirectoryViewModelTests.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/10/22.
//

import XCTest
import ReactiveSwift
@testable import SquareTakeHome

class DirectoryViewModelTests: XCTestCase {
    
    func testFetchEmployeesSuccess() {
        let expectation = self.expectation(description: "Fetched 2 employee view models")
        let vm = DirectoryViewModel(employeeManager: MockEmployeeAPIManager(withMockType: .success))
        
        vm.fetchSignal.observeValues { viewModels in
            XCTAssertEqual(viewModels.count, 1)
            expectation.fulfill()
        }
        
        vm.getEmployeeViewModels()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchEmployeesFailure() {
        let expectation = self.expectation(description: "Could not fetch employees")
        let vm = DirectoryViewModel(employeeManager: MockEmployeeAPIManager(withMockType: .malformed))
        
        vm.errorSignal.observeValues { error in
            expectation.fulfill()
        }
        
        vm.getEmployeeViewModels()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchEmployeesEmpty() {
        let expectation = self.expectation(description: "Could not fetch employees")
        let vm = DirectoryViewModel(employeeManager: MockEmployeeAPIManager(withMockType: .empty))
        
        vm.errorSignal.observeValues { error in
            expectation.fulfill()
        }
        
        vm.getEmployeeViewModels()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
