//
//  EmployeeURL.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

enum EmployeeURL : String, CaseIterable {
    
    static let baseURLString = "https://s3.amazonaws.com/sq-mobile-interview"
    
    case standard
    case malformed
    case empty
    
    var url: URL {
        let pathComponent: String
        switch self {
        case .standard:
            pathComponent = "employees.json"
        case .malformed:
            pathComponent = "employees_malformed.json"
        case .empty:
            pathComponent = "employees_empty.json"
        }
        
        var url = URL(string: EmployeeURL.baseURLString)
        url?.appendPathComponent(pathComponent)
        
        if let url = url {
            return url
        } else {
            fatalError(NetworkErrors.badURL(urlString: pathComponent).errorMessage)
        }
    }
}
