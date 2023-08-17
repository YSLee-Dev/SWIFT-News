//
//  MainCategoryUsecaseProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

protocol MainCategoryUsecaseProtocol {
    func categoryList() -> Observable<[String]>
}
