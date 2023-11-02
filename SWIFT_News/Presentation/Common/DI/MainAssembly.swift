//
//  MainAssembly.swift
//  SWIFT_News
//
//  Created by 이윤수 on 11/2/23.
//

import Foundation

import Swinject

struct MainAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(MainViewModel.self) { container in
            MainViewModel(loadUsecase: container.resolve(MainNewsLoadUsecaseProtocol.self)!, 
                          categoryUsecase: container.resolve(MainCategoryUsecaseProtocol.self)!
            )
        }
        
        container.register(MainVC.self) { container in
            MainVC(viewModel: container.resolve(MainViewModel.self)!)
        }
    }
}
