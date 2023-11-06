//
//  MainCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Swinject

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var mainVC: MainVC!
    var container: Container
    
    var childCoordinator: [CoordinatorProtocol] = [] {
        didSet {
            print(childCoordinator)
        }
    }
    
    deinit {
        print("MainCoordinator DEINIT")
    }
    
    init(
        _ navigationController: UINavigationController,
        _ container: Swinject.Container
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        self.navigationController.pushViewController(self.mainVC, animated: false)
        self.mainVC.viewModel.delegate = self
    }
}

extension MainCoordinator: MainVCActionProtocol {
    func detailVCPush(_ data: NewsData) {
        let detailCoordinator = DetailCoordinator(self.navigationController)
        detailCoordinator.detailVC = self.container.resolve(DetailVC.self)!
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
