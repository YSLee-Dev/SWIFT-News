//
//  CoordinatorProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Swinject

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController {get}
    var childCoordinator: [CoordinatorProtocol] {get}
    
    func start()
}
