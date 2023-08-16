//
//  MainCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    var childCoordinator: [CoordinatorProtocol] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainVC()
        self.navigationController.pushViewController(mainVC, animated: false)
    }
}
