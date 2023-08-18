//
//  MainVC.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa
import RxDataSources

final class MainVC: UIViewController {
    lazy var tableView = MainTableView().then {
        $0.delegate = self
    }
    let categoryView = MainCategoryView()
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
        [self.tableView, self.categoryView]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.categoryView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
    }
    
    func bind() {
        let input = MainViewModel.Input(
            categoryTap: self.categoryView.collectionView.rx.modelSelected(String.self)
                .startWith("애플")
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
            .drive(self.categoryView.collectionView.rx.items) { collectionView, row, data in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainCategoryViewCell.id, for: IndexPath(row: row, section: 0)
                ) as? MainCategoryViewCell else {return UICollectionViewCell()}
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
        
        self.categoryView.collectionView.selectItem(
            at: IndexPath(row: 0, section: 0),
            animated: true,
            scrollPosition: .bottom
        )
        
        output.newsList
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.bag)
        
        output.refreshStop
            .drive(self.tableView.refresh.rx.isRefreshing)
            .disposed(by: self.bag)
    }
    
    func isCategoryViewHidden(_ hidden: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if hidden {
                self.categoryView.transform = CGAffineTransform(translationX: 0, y: 100)
            } else {
                self.categoryView.transform = .identity
            }
        })
    }
}

extension MainVC: UITableViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        guard velocity.y != 0 else {return}
        self.isCategoryViewHidden(velocity.y > 0)
    }
}
