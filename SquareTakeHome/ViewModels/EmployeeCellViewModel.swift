//
//  EmployeeCellViewModel.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import UIKit

class EmployeeCellViewModel: Hashable {
    let id: String
    let fullName: String
    let teamName: String
    let bio: String?
    let photoUrlSmall: String?
    var smallPhoto: UIImage?
    
    init(employee: Employee) {
        id = employee.uuid
        fullName = employee.fullName
        teamName = employee.team
        bio = employee.biography
        photoUrlSmall = employee.photoUrlSmall
        smallPhoto = UIImage(systemName: "person.circle")?.withTintColor(.lightGray)
    }
    
    func setEmployeePhoto(image: UIImage) {
        self.smallPhoto = image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: EmployeeCellViewModel, rhs: EmployeeCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
