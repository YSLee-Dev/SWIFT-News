//
//  MainTableCell.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Then
import SnapKit

class MainTableCell: UITableViewCell {
    static let id = "MainTableCell"
    
    var titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    var descriptionLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 14)
    }
    
    var dataLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableCell {
    private func layout() {
        [self.titleLabel, self.descriptionLabel, self.dataLabel].forEach {
            self.contentView.addSubview($0)
        }
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.dataLabel.snp.makeConstraints {
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(self.titleLabel)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func attribute() {
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
    func dataSet(_ data: NewsData) {
        self.dataLabel.text = data.date
        self.descriptionLabel.text = data.description
        self.titleLabel.text = data.title
    }
}
