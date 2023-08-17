//
//  URLSessionProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift

protocol URLSessionProtocol {
    func request(_ request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)>
}
