//
//  EmployeeCollectionViewCell.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

/// A subclass of UICollectionViewCell that dispays information related to an employee
class EmployeeCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    static let estimatedRowHeight: CGFloat = 200
    private static let spacingConstant: CGFloat = 10
    
    @UsesAutoLayout
    private(set) var nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return name
    }()
    
    @UsesAutoLayout
    private(set) var teamLabel: UILabel = {
        let team = UILabel()
        team.numberOfLines = 0
        team.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        team.textColor = .systemBlue
        return team
    }()
    
    @UsesAutoLayout
    private(set) var employeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    @UsesAutoLayout
    private(set) var employeeBioLabel: UILabel = {
        let bioLabel = UILabel()
        bioLabel.numberOfLines = 0
        bioLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        bioLabel.textAlignment = .center
        return bioLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.systemBackground
        
        
        let stack = UIStackView(arrangedSubviews: [employeeImageView, nameLabel, teamLabel, employeeBioLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.setCustomSpacing(10, after: teamLabel)
        
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: 100),
            employeeImageView.widthAnchor.constraint(equalToConstant: 100),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                          constant: EmployeeCollectionViewCell.spacingConstant),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                           constant: -EmployeeCollectionViewCell.spacingConstant)
        ])
    }
    
    func configure(_ employeeVM: EmployeeCellViewModel) {
        nameLabel.text = employeeVM.fullName
        teamLabel.text = employeeVM.teamName
        employeeImageView.reactive.image <~ employeeVM.smallPhoto
            .producer
            .take(until: self.reactive.prepareForReuse)
        
        employeeBioLabel.text = employeeVM.bio
    }
}
