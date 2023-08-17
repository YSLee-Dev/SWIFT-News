//
//  NetworkServiceProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        url: URLComponents,
        decodingType: T.Type
    ) -> Single<Result<T, URLError>>
}
