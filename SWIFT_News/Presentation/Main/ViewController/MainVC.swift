//
//  MainVC.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import SnapKit

import RxSwift
import RxCocoa
import RxDataSources

final class MainVC: UIViewController {
    let tableView = MainTableView()
    let headerView = MainTableHeaderView()
    let viewModel: MainViewModel
    let bag = DisposeBag()
    
    init(
        viewModel: MainViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attribute()
        self.layout()
        self.bind()
    }
}

private extension MainVC {
    func attribute() {
        self.title = "NEWS"
        self.view.backgroundColor = .systemBackground
    }
    
    func layout() {
        [self.tableView, self.headerView]
            .forEach {
                self.view.addSubview($0)
            }
        self.headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        let input = MainViewModel.Input(
            categoryTap: self.headerView.collectionView.rx.modelSelected(String.self)
                .asObservable(),
            newsTap: self.tableView.rx.modelSelected(NewsData.self)
                .asObservable(),
            refresh: self.tableView.refresh.rx.controlEvent(.valueChanged)
                .asObservable(),
            scroll: self.tableView.rx.willDisplayCell.map {$0.indexPath}
                .asObservable()
        )
        
        let output = viewModel.transform(input: input)
        output.categoryList
            .drive(self.headerView.collectionView.rx.items) { collectionView, row, data in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainTableHeaderCell.id, for: IndexPath(row: row, section: 0)
                ) as? MainTableHeaderCell else {return UICollectionViewCell()}
                cell.mainLabel.text = data
                return cell
            }
            .disposed(by: self.bag)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<NewsSection>(
            animationConfiguration: .init(insertAnimation: .left, deleteAnimation: .right),
            configureCell: { _, tableView, index, data in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: MainTableCell.id, for: index
                ) as? MainTableCell else {return UITableViewCell()}
                cell.dataSet(data)
                return cell
            })
        
        output.newsList
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.bag)
        
        output.refreshStop
            .drive(self.tableView.refresh.rx.isRefreshing)
            .disposed(by: self.bag)
    }
}
