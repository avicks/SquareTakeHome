//
//  Coordinator.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
