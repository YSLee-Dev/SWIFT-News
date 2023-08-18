//
//  MainCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    var childCoordinator: [CoordinatorProtocol] = [] {
        didSet {
            print(childCoordinator)
        }
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        viewModel.delegate = self
        let mainVC = MainVC(viewModel: viewModel)
        
        self.navigationController.pushViewController(mainVC, animated: false)
    }
}

extension MainCoordinator: MainVCActionProtocol {
    func detailVCPush(_ data: NewsData) {
        let detailCoordinator = DetailCoordinator(self.navigationController)
        detailCoordinator.newsData = data
        detailCoordinator.start()
        detailCoordinator.coordinatorDelegate = self
        
        self.childCoordinator.append(detailCoordinator)
    }
}

extension MainCoordinator: DetailCoordinatorProtocol {
    func viewDidDisappear(coordinator: DetailCoordinator) {
        self.childCoordinator = self.childCoordinator.filter {
            $0 !== coordinator
        }
    }
}
