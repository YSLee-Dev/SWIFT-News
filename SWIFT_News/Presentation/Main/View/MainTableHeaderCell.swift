//
//  MainTableHeaderCell.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import SnapKit
import Then

class MainTableHeaderCell: UICollectionViewCell {
    static let id = "MainTableHeaderCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.mainLabel.backgroundColor = .gray.withAlphaComponent(0.8)
            } else {
                self.mainLabel.backgroundColor = .systemBackground
            }
        }
    }
    
    var mainLabel = UILabel().then {
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.textColor = .label
        $0.font = .boldSystemFont(ofSize: 14)
        $0.backgroundColor = .systemBackground
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableHeaderCell {
    private func layout() {
        self.contentView.addSubview(self.mainLabel)
        self.mainLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
