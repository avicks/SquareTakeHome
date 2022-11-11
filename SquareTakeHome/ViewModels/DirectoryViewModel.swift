//
//  DirectoryViewModel.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import Foundation
import ReactiveSwift

struct DirectoryViewModel {
    
    let (fetchSignal, fetchObserver) = Signal<[EmployeeCellViewModel], Never>.pipe()
    let (errorSignal, errorObserver) = Signal<Error, Never>.pipe()
    
    private let employeeManager: EmployeeAPIManagerProtocol
    
    init(employeeManager: EmployeeAPIManagerProtocol = EmployeeAPIManager(withEmployeeEndpoint: EmployeeURL.standard.url)) {
        self.employeeManager = employeeManager        
    }
    
    func getEmployeeViewModels() {
        self.employeeManager.fetchEmployees { result in
            switch result {
            case .success(let employees):
                if let vms = employees.map({ EmployeeCellViewModel(employee: $0) }) as? [EmployeeCellViewModel] {
                    if vms.count > 0 {
                        fetchObserver.send(value: vms)
                    } else {
                        errorObserver.send(value: NetworkErrors.emptyDirectory)
                    }
                } else {
                    errorObserver.send(value: NetworkErrors.decodeEmployees)
                }
            case .failure(let error):
                errorObserver.send(value: error)
            }
        }
    }
}
