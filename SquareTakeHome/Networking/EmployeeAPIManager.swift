//
//  EmployeeAPIManager.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/9/22.
//

import UIKit

protocol EmployeeAPIManagerProtocol {
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void)
    func fetchEmployeeImage(withUrl imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
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
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let employees = try? decoder.decode(Employees.self, from: data) else {
                completion(.failure(NetworkErrors.decodeEmployees))
                return
            }
            
            completion(.success(employees.employees))
        }.resume()
    }
    
    func fetchEmployeeImage(withUrl imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = EmployeeImageCache.shared.getImage(forKey: imageUrl.asCacheKey) {
            completion(.success(image))
        } else {
            let request = URLRequest(url: imageUrl)
            URLSession.shared.dataTask(with: request) { data, _, _ in
                if let data = data,
                   let image = UIImage(data: data) {
                    EmployeeImageCache.shared.store(image: image, forKey: imageUrl.asCacheKey)
                    completion(.success(image))
                    return
                } else {
                    completion(.failure(NetworkErrors.fetchImage))
                }
            }.resume()
        }
    }
}
