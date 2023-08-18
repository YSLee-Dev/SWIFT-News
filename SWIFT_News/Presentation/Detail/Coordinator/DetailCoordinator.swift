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
    var newsData: NewsData?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DetailViewModel()
        viewModel.delegate = self
        viewModel.newsData.onNext(
            newsData ?? .init(
                id: "NONE", title: "정보없음", url: URL(string: "https://www.apple.com")!, description: "정보없음", date: ""
            )
        )
        
        let detailVC = DetailVC(viewModel: viewModel)
        
        self.navigationController.pushViewController(detailVC, animated: true)
    }
}

extension DetailCoordinator: DetailVCActionProtocol {
    func viewDidDisappear() {
        self.coordinatorDelegate?.viewDidDisappear(coordinator: self)
    }
}
