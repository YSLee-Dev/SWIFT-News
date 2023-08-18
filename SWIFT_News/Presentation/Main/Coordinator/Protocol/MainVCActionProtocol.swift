//
//  MainVCActionProtocol.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/18.
//

import Foundation

protocol MainVCActionProtocol: AnyObject {
    func detailVCPush(_ data: NewsData)
}
