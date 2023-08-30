//
//  MainCategoryView.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Then
import SnapKit

class MainCategoryView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.alwaysBounceVertical = false
        $0.collectionViewLayout = self.collectionViewLayout()
        $0.register(MainCategoryViewCell.self, forCellWithReuseIdentifier: MainCategoryViewCell.id)
        $0.register(MainTableCategorySearchCell.self, forCellWithReuseIdentifier: MainTableCategorySearchCell.id)
        $0.delegate = nil
        $0.dataSource = nil
        $0.backgroundColor = .systemGroupedBackground
    }
    
    init() {
        super.init(frame: .zero)
        self.layout()
        self.attirbute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainCategoryView {
    func attirbute() {
        self.backgroundColor = .systemGroupedBackground
    }
    
    func layout() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0)
        )
        var group: NSCollectionLayoutGroup!
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
}
