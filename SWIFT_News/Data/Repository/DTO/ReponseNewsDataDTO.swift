//
//  ReponseNewsDataDTO.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

struct ReponseNewsDataDTO: Decodable {
    var items: [News]
    var start: Int
    
    func toDomain() -> [NewsSection] {
        [NewsSection(id: "\(start)", items:
                        items.map {
            NewsData(
                id: "\($0.title)\($0.pubDate) \(start) \($0.link)",
                title: $0.title
                    .replacingOccurrences(of: "<b>", with: " ")
                    .replacingOccurrences(of: "</b>", with: " "),
                url: (URL(string: $0.link) ?? URL(string: "https://www.apple.com"))!,
                description: $0.description
                    .replacingOccurrences(of: "<b>", with: " ")
                    .replacingOccurrences(of: "</b>", with: " "),
                date: $0.pubDate
            )
        }
        )]
    }
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
