//
//  MainTableCategorySearchCell.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/30.
//

import UIKit

import Then
import SnapKit

class MainTableCategorySearchCell: UICollectionViewCell {
    static let id = "MainTableCategorySearchCell"
    
    override func prepareForReuse() {
        self.textField.text = ""
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.textField.backgroundColor = .systemGray2
                self.textField.textColor = .systemBackground
            } else {
                self.textField.backgroundColor = .systemBackground
                self.textField.textColor = .label
                self.textField.text = ""
            }
        }
    }
    
    var textField = UITextField().then {
        $0.placeholder = "검색"
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

extension MainTableCategorySearchCell {
    private func layout() {
        self.contentView.addSubview(self.textField)
        self.textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
