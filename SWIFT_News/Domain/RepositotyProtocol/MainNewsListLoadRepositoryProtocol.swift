//
//  MainNewsListLoadRepositoryProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

protocol MainNewsListLoadRepositoryProtocol {
    func newNewsLoad(requestModel: RequestNewsDataModel) -> Single<ReponseNewsDataDTO>
}
