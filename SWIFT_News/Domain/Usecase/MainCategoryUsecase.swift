//
//  MainCategoryUsecase.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

class MainCategoryUsecase: MainCategoryUsecaseProtocol {
    func categoryList() -> Observable<[String]> {
        Observable<[String]>.create {
            $0.onNext(
                NewsCategoty.allCases.map {
                    $0.rawValue
                }
            )
            $0.onCompleted()
            return Disposables.create()
        }
    }
}
