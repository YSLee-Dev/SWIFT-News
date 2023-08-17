//
//  ReponseNewsDataDTO.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

struct ReponseNewsDataDTO: Decodable {
    var items: [News]
    
    func toDomain() -> [NewsData] {
        items.map {
            NewsData(
                title: $0.title,
                url: (URL(string: $0.link) ?? URL(string: "https://www.apple.com"))!,
                description: $0.description,
                date: $0.pubDate
            )
        }
    }
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
