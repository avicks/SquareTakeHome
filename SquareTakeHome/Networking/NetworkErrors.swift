//
//  NetworkErrors.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

enum NetworkErrors: Error {
    case badURL(urlString: String)
    case fetchEmployees
    case decodeEmployees
    
    var errorMessage: String {
        let messageString: String
        switch self {
        case .badURL(urlString: let urlString):
            messageString = "Could not initialize URL from \(urlString)."
        case .fetchEmployees:
            messageString = "Could not load employee directory."
        case .decodeEmployees:
            messageString = "Could not decode employee data."
        }
        
        return messageString
    }
}
