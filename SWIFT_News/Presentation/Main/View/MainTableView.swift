//
//  MainTableView.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Then

class MainTableView: UITableView {
    var refresh = UIRefreshControl().then {
        $0.tintColor = .label
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainTableView {
    func attribute() {
        // 임시
        self.dataSource = nil
        self.delegate = nil
        
        self.backgroundColor = .systemBackground
        self.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.id)
        self.refreshControl = self.refresh
    }
}
