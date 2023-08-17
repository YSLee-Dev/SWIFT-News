//
//  NewsSection.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxDataSources

struct NewsSection: AnimatableSectionModelType {
    let id: String
    var items: [Item]
}

extension NewsSection {
    var identity: String {
        self.id
    }
    
    typealias Item = NewsData
    
    init(original: NewsSection, items: [NewsData]) {
        self = original
        self.items = items
    }
}
