//
//  DomainAssembly.swift
//  SWIFT_News
//
//  Created by 이윤수 on 11/2/23.
//

import Foundation

import Swinject

struct DomainAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(MainNewsLoadUsecaseProtocol.self) { container in
            MainNewsLoadUsecase(repository: container.resolve(MainNewsListLoadRepositoryProtocol.self)!)
        }
        
        container.register(MainCategoryUsecaseProtocol.self) { _ in
            MainCategoryUsecase()
        }
    }
}
