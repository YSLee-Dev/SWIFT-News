//
//  DetailAssembly.swift
//  SWIFT_News
//
//  Created by 이윤수 on 11/2/23.
//

import Foundation

import Swinject

struct DetailAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(DetailViewModel.self) { _ in
            DetailViewModel()
        }
        
        container.register(DetailVC.self) { container in
            DetailVC(viewModel: container.resolve(DetailViewModel.self)!)
        }
    }
}
