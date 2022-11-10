//
//  EmployeeTests.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/9/22.
//

import XCTest
@testable import SquareTakeHome

class EmplyoeeModelTests: XCTestCase {
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func testValidEmployeeData() throws {
        let employee = try decoder.decode(Employee.self, from: validEmployeeData)
        XCTAssertEqual(employee.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c")
        XCTAssertEqual(employee.fullName, "Justine Mason")
        XCTAssertEqual(employee.phoneNumber, "5553280123")
        XCTAssertEqual(employee.emailAddress, "jmason.demo@squareup.com")
        XCTAssertEqual(employee.biography, "Engineer on the Point of Sale team.")
        XCTAssertEqual(employee.photoUrlSmall, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(employee.photoUrlLarge, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")
        XCTAssertEqual(employee.team, "Point of Sale")
        XCTAssertEqual(employee.employeeType, EmployeeType.fullTime)
    }
    
    func testMalformedEmployeeData() throws {
        XCTAssertThrowsError(try decoder.decode(Employee.self, from: malformedEmployeeData))
    }
}
