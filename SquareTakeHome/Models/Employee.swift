//
//  Employee.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

/// How the employee is classified
enum EmployeeType: String, Codable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

/// Employee model encapsulating employees at Square
///   Documentation that led to the data model below found at:
///   https://square.github.io/microsite/mobile-interview-project/
struct Employee: Codable {
    /// The unique identifier for the employee. Represented as a UUID
    let uuid: String
    /// The full name of the employee
    let fullName: String
    /// The email address of the employee.
    let emailAddress: String
    /// The team they are on, represented as a human readable string.
    let team: String
    /// How the employee is classified
    let employeeType: EmployeeType
    /// The phone number of the employee, sent as an unformatted string (eg, 5556661234)
    let phoneNumber: String?
    /// A short, tweet-length (~300 chars) string that the employee provided to describe themselves
    let biography: String?
    /// The URL of the employee’s small photo. Useful for list view.
    let photoUrlSmall: String?
    /// The URL of the employee's full-size photo
    let photoUrlLarge: String?
}
