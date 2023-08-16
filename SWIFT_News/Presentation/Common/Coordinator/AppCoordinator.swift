//
//  AppCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    var childCoordinator: [CoordinatorProtocol] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.attribute()
    }
    
    func start() {
        let mainCooridnator = MainCoordinator(self.navigationController)
        mainCooridnator.start()
        self.childCoordinator.append(mainCooridnator)
    }
}

private extension AppCoordinator {
    func attribute() {
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
}
