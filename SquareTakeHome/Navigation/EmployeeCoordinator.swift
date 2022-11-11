//
//  EmployeeCoordinator.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import UIKit

class EmployeeCoordinator: Coordinator {
    
    private let employeeEndpoint = EmployeeURL.standard.url
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        var vm = DirectoryViewModel(employeeManager: EmployeeAPIManager.init(withEmployeeEndpoint: employeeEndpoint))
        vm.coordinator = self
        let vc = DirectoryViewController()
        vc.viewModel = vm
        
        navigationController.pushViewController(vc, animated: true)
    }
}
