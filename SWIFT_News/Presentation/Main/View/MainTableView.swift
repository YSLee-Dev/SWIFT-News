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
        self.dataSource = self
        self.delegate = self
        
        self.backgroundColor = .systemBackground
        self.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.id)
        self.register(MainTableHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableHeaderView.id)
        self.refreshControl = self.refresh
    }
}

// 임시
extension MainTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.id, for: indexPath) as? MainTableCell else {return UITableViewCell()}
        cell.dataLabel.text = "날짜"
        cell.descriptionLabel.text = "내용"
        cell.titleLabel.text = "타이틀"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableHeaderView.id) as? MainTableHeaderView else {return UITableViewHeaderFooterView()}
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
}
