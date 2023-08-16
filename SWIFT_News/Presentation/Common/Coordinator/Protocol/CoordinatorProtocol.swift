//
//  CoordinatorProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController {get}
    var childCoordinator: [CoordinatorProtocol] {get}
    
    init(_ navigationController: UINavigationController)
    func start()
}
