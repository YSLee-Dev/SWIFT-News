//
//  NewsData.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxDataSources

struct NewsData: Equatable, IdentifiableType {
    let id: String
    let title: String
    let url: URL
    let description: String
    let date: String
}

extension NewsData {
    var identity: String {
        self.id
    }
}
