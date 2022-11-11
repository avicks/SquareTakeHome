//
//  DirectoryViewController.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import UIKit

class DirectoryViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var refreshControl: UIRefreshControl!
    private var directoryCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, EmployeeCellViewModel>!

    var viewModel : DirectoryViewModel? = nil {
        didSet {
            self.setupWithViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Square Directory"
        refreshControl = makeRefreshControl()
        setupCollectionView()
        configureDataSource()
        setupWithViewModel()
    }
    
    func setupWithViewModel() {
        guard isViewLoaded, let viewModel = viewModel else { return }
        
        viewModel.fetchSignal.observeValues{ [weak self] employeeVMs in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.directoryCollectionView.clearBackground()
                self.appySnapshot(withEmployeeViewModels: employeeVMs)
            }
        }
        
        viewModel.errorSignal.observeValues { [weak self] error in
            guard let self = self else { return }
            var message = ""
            if let error = error as? NetworkErrors {
                message = error.errorMessage
            } else {
                message = "Failed to load directory."
            }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            // give a slight pause to ensure we signal an attempt to refresh if our error remains
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.directoryCollectionView.setBackgroundView(withMessage: message)
            }
        }
        
        viewModel.getEmployeeViewModels()
    }
    
    private func makeRefreshControl() -> UIRefreshControl {
        return UIRefreshControl(frame: .zero,
                                          primaryAction:
                                    UIAction(handler: { [weak self] _ in
            DispatchQueue.main.async {
                self?.directoryCollectionView.clearBackground()
            }
            self?.viewModel?.getEmployeeViewModels()
        }))
    }
    
    private func fetchEmployees() {
        refreshControl.beginRefreshing()
        viewModel?.getEmployeeViewModels()
    }
}

//MARK: - UICollectionView
extension DirectoryViewController {
    private func setupCollectionView() {
        directoryCollectionView = UICollectionView(frame: view.bounds,
                                                   collectionViewLayout: makeCollectionViewLayout())
        directoryCollectionView.backgroundColor = .systemBackground
        directoryCollectionView.refreshControl = refreshControl
        view.addSubview(directoryCollectionView)
        
        directoryCollectionView.register(EmployeeCollectionViewCell.self,
                                         forCellWithReuseIdentifier: EmployeeCollectionViewCell.reuseIdentifier)
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(EmployeeCollectionViewCell.estimatedRowHeight))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

        let layout = UICollectionViewCompositionalLayout(section: layoutSection)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, EmployeeCellViewModel>(collectionView: directoryCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, employeeVM: EmployeeCellViewModel) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCollectionViewCell.reuseIdentifier, for: indexPath) as? EmployeeCollectionViewCell else {
                fatalError("Unable to dequeue employee cell")
            }
            
            cell.configure(employeeVM)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, EmployeeCellViewModel>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func appySnapshot(withEmployeeViewModels vms: [EmployeeCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EmployeeCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(vms, toSection: Section.main)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}
