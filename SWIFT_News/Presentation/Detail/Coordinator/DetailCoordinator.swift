//
//  DetailCoordinator.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/18.
//

import UIKit

class DetailCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinator: [CoordinatorProtocol] = []
    
    weak var coordinatorDelegate: DetailCoordinatorProtocol?
    
    var detailVC: DetailVC!
    var newsData: NewsData?
    
    init(
        _ navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("DetailCoordinator DEINIT")
    }
    
    func start() {
        self.detailVC.viewModel.delegate = self
        self.detailVC.viewModel.newsData.onNext(
            newsData ?? .init(
                id: "NONE", title: "정보없음", url: URL(string: "https://www.apple.com")!, description: "정보없음", date: ""
            )
        )
        
        self.navigationController.pushViewController(self.detailVC, animated: true)
    }
}

extension DetailCoordinator: DetailVCActionProtocol {
    func viewDidDisappear() {
        self.coordinatorDelegate?.viewDidDisappear(coordinator: self)
    }
}
