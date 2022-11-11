//
//  EmployeeCellViewModel.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import UIKit
import ReactiveSwift

class EmployeeCellViewModel: Hashable {
    
    private static let defaultPhoto = UIImage(systemName: "person.circle")?.withTintColor(.lightGray)
    
    let id: String
    let fullName: String
    let teamName: String
    let bio: String?
    let photoUrlSmall: String?
    var smallPhoto = MutableProperty<UIImage?>(nil)
    
    init(employee: Employee) {
        id = employee.uuid
        fullName = employee.fullName
        teamName = employee.team
        bio = employee.biography
        photoUrlSmall = employee.photoUrlSmall
        smallPhoto.swap(EmployeeCellViewModel.defaultPhoto)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: EmployeeCellViewModel, rhs: EmployeeCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
