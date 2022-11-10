//
//  DirectoryViewModel.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import Foundation

class DirectoryViewModel {
    private let employeeManager: EmployeeAPIManager
    
    init(employeeManager: EmployeeAPIManager = EmployeeAPIManager(withEmployeeEndpoint: EmployeeURL.standard.url)) {
        self.employeeManager = employeeManager
    }
}
