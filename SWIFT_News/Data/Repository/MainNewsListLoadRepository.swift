//
//  MainNewsListLoadRepository.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift
import RxOptional

class MainNewsListLoadRepository: MainNewsListLoadRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    
    init (
        networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.networkService = networkService
    }
    
    func newNewsLoad(requestModel: RequestNewsDataModel) -> RxSwift.Single<ReponseNewsDataDTO> {
        var url = URLComponents()
        url.scheme = ServerURL.scheme
        url.host = ServerURL.host
        url.path = ServerURL.path
        url.queryItems = [
            URLQueryItem(name: ServerQurey.query, value: requestModel.query),
            URLQueryItem(name: ServerQurey.display, value: String(requestModel.display)),
            URLQueryItem(name: ServerQurey.start, value: String(requestModel.start))
        ]
        
        return self.networkService.request(
            url: url,
            decodingType: ReponseNewsDataDTO.self
        )
        .map {data -> ReponseNewsDataDTO? in
            guard case .success(let value) = data else {return nil}
            return value
        }
        .asObservable()
        .replaceNilWith(.init(items: []))
        .asSingle()
    }
}
