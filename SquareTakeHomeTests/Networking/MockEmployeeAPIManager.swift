//
//  MockEmployeeAPIManager.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/10/22.
//

import UIKit
@testable import SquareTakeHome

enum APIMockType {
    case success
    case malformed
    case empty
}

class MockEmployeeAPIManager: EmployeeAPIManagerProtocol {
    let mockType: APIMockType
    
    init(withMockType type: APIMockType) {
        self.mockType = type
    }
    
    func fetchEmployees(completion: @escaping (Result<[SquareTakeHome.Employee], Error>) -> Void) {
        switch self.mockType {
        case .empty:
            completion(.success([]))
        case .malformed:
            completion(.failure(NSError(domain: "MockEmployeeAPIManagerFailure", code: 0)))
        case .success:
            let employees = [Employee(uuid: "1",
                                      fullName: "Alex",
                                      emailAddress: "",
                                      team: "",
                                      employeeType: .fullTime,
                                      phoneNumber: "",
                                      biography: "",
                                      photoUrlSmall: "",
                                      photoUrlLarge: "")]
            completion(.success(employees))
        }
    }
    
    func fetchEmployeeImage(withUrl imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imagePath = NSString(string: "soccer")
        completion(.success(UIImage(named: String(describing: imagePath))!))
    }
}
