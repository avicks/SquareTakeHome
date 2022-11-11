//
//  NetworkErrors.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

enum NetworkErrors: Error {
    case badURL(urlString: String)
    case decodeEmployees
    case emptyDirectory
    case fetchEmployees(error: Error?)
    
    var errorMessage: String {
        var messageString: String
        switch self {
        case .badURL(urlString: let urlString):
            messageString = "Could not initialize URL from \(urlString)."
        case .decodeEmployees:
            messageString = "Could not decode employee data."
        case .emptyDirectory:
            messageString = "The directory is empty."
        case .fetchEmployees(let error):
            messageString = "Could not load employee directory."
            if let error = error {
                messageString.append("\nError: \(error)")
            }
        }
        
        return messageString
    }
}
