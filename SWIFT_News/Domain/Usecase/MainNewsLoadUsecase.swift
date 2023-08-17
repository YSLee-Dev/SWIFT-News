//
//  MainNewsLoadUsecase.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

class MainNewsLoadUsecase: MainNewsLoadUsecaseProtocol {
    let repository: MainNewsListLoadRepositoryProtocol
    
    init (
        repository: MainNewsListLoadRepositoryProtocol = MainNewsListLoadRepository()
    ) {
        self.repository = repository
    }
    
    func newsLoad(data: RequestNewsDataModel) -> Single<[NewsData]> {
        self.repository.newNewsLoad(requestModel: data)
            .map {
                $0.toDomain()
            }
    }
}
