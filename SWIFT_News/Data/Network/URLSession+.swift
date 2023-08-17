//
//  URLSession+.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

extension URLSession: URLSessionProtocol {
    func request(_ request: URLRequest) -> RxSwift.Observable<(response: HTTPURLResponse, data: Data)> {
        self.rx.response(request: request)
    }
}
