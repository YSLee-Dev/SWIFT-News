//
//  RequestNewsDataModel.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

struct RequestNewsDataModel {
    /// 시작 index, 1 ~ 1000
    let start: Int
    /// 검색결과 출력 건 수, 10 ~ 100
    let display: Int
    /// 검색어
    let query: String
}
