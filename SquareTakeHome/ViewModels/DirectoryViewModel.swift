//
//  DirectoryViewModel.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import Foundation
import ReactiveSwift

/// View Model responsible for fetching employees and preparing them for display
struct DirectoryViewModel {
    weak var coordinator: EmployeeCoordinator!
    
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
                        vms.forEach{ getImage(forEmployeeViewModel: $0) }
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
    
    func getImage(forEmployeeViewModel vm: EmployeeCellViewModel) {
        guard let url = URL(string: vm.photoUrlSmall ?? "") else {
            return
        }
        self.employeeManager.fetchEmployeeImage(withUrl: url) { result in
            switch result {
            case .success(let photo):
                vm.smallPhoto.swap(photo)
            case .failure(_):
                // silently fail image download as we have a placeholder
                return
            }
        }
    }
}
