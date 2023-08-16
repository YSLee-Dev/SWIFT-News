//
//  MainTableHeaderView.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Then
import SnapKit

class MainTableHeaderView: UITableViewHeaderFooterView {
    // 임시
    var temp = ["1", "22", "333", "4444", "55555", "666666", "7777777", "88888888", "999999999", "1010101010"]
    static let id = "MainTableHeaderView"
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.collectionViewLayout = self.collectionViewLayout()
        $0.register(MainTableHeaderCell.self, forCellWithReuseIdentifier: MainTableHeaderCell.id)
        $0.delegate = nil
        // 임시
        $0.dataSource = self
        $0.backgroundColor = .label
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableHeaderView {
    private func attribute() {
    }
    
    private func layout() {
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)
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

extension MainTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    // 임시
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableHeaderCell.id, for: indexPath) as? MainTableHeaderCell else {return UICollectionViewCell()}
        cell.mainLabel.text = temp[indexPath.row]
        return cell
    }
}
