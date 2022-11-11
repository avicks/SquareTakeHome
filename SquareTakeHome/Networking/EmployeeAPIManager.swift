//
//  EmployeeAPIManager.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

protocol EmployeeAPIManagerProtocol {
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void)
}

final class EmployeeAPIManager: EmployeeAPIManagerProtocol {
    private let emplyoeeEndpoint: URL
    
    init(withEmployeeEndpoint endpoint: URL) {
        self.emplyoeeEndpoint = endpoint
    }
    
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        let request = URLRequest(url: self.emplyoeeEndpoint)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NetworkErrors.fetchEmployees(error: nil)))
                return
            }
            
            let decoder = JSONDecoder()
            guard let employees = try? decoder.decode(Employees.self, from: data) else {
                completion(.failure(NetworkErrors.decodeEmployees))
                return
            }
            
            completion(.success(employees.employees))
        }.resume()
    }
}
