//
//  DataAssembly.swift
//  SWIFT_News
//
//  Created by 이윤수 on 11/2/23.
//

import Foundation

import Swinject

struct DataAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }
        
        container.register(MainNewsListLoadRepositoryProtocol.self) {  container in
            MainNewsListLoadRepository(networkService: container.resolve(NetworkServiceProtocol.self)!)
        }
    }
}
