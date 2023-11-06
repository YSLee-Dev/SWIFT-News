//
//  AppCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Swinject

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var container: Container!
    
    var childCoordinator: [CoordinatorProtocol] = []
    
    init(
        _ navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.attribute()
    }
    
    func start() {
        let mainCooridnator = MainCoordinator(self.navigationController, container)
        let mainVC = container.resolve(MainVC.self)!
        mainCooridnator.mainVC = mainVC
        
        mainCooridnator.start()
        mainCooridnator.container = self.container
        self.childCoordinator.append(mainCooridnator)
    }
}

private extension AppCoordinator {
    func attribute() {
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        self.navigationController.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
