//
//  NetworkService.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

class NetworkService: NetworkServiceProtocol {
    let urlSession: URLSessionProtocol
    
    init(
        urlSession: URLSessionProtocol = URLSession.shared
    ) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(
        url: URLComponents,
        decodingType: T.Type
    ) -> Single<Result<T, URLError>> {
        guard let url = url.url else {return .just(.failure(URLError(.badURL)))}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let header = [
            "X-Naver-Client-Id": RequestToken.id,
            "X-Naver-Client-Secret": RequestToken.secret
        ]
        header.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return self.urlSession.request(request)
            .map {
                switch $0.response.statusCode {
                case 200 ..< 299:
                    do {
                        let data = try JSONDecoder().decode(decodingType, from: $0.data)
                        return .success(data)
                    } catch {
                        return .failure(URLError(.cannotParseResponse))
                    }
                case 400 ..< 500:
                    return .failure(URLError(.clientCertificateRejected))
                case 500 ..< 599:
                    return .failure(URLError(.badServerResponse))
                default:
                    return .failure(URLError(.unknown))
                }
            }
            .asSingle()
    }
}
