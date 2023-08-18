//
//  MainViewModel.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

class MainViewModel {
    let loadUsecase: MainNewsLoadUsecaseProtocol
    let categoryUsecase: MainCategoryUsecaseProtocol
    
    private var newsList = BehaviorRelay<[NewsSection]>(value: [])
    private var page = 1
    let bag = DisposeBag()
    
    struct Input {
        let categoryTap: Observable<String>
        let newsTap: Observable<NewsData>
        let refresh: Observable<Void>
        let scroll: Observable<IndexPath>
    }
    
    struct Output {
        let newsList: Driver<[NewsSection]>
        let categoryList: Driver<[String]>
        let refreshStop: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        self.newsListLoad(input: input)
        return Output(
            newsList: self.newsList
                .asDriver(onErrorDriveWith: .empty()),
            categoryList: self.categoryUsecase.categoryList()
                .asDriver(onErrorDriveWith: .empty()),
            refreshStop: self.newsList.map {_ in false}
                .asDriver(onErrorDriveWith: .empty())
        )
    }
    
    init (
        loadUsecase: MainNewsLoadUsecaseProtocol = MainNewsLoadUsecase(),
        categoryUsecase: MainCategoryUsecaseProtocol = MainCategoryUsecase()
    ) {
        self.loadUsecase = loadUsecase
        self.categoryUsecase = categoryUsecase
    }
}

private extension MainViewModel {
    func newsListLoad(input: Input) {
        let reload = Observable.merge(
            input.categoryTap,
            input.refresh.withLatestFrom(input.categoryTap)
        )
            .share()
        
        reload
            .withUnretained(self)
            .subscribe(onNext: { viewModel, _ in
                viewModel.page = 1
            })
            .disposed(by: self.bag)
        
        reload
            .startWith("애플")
            .withUnretained(self)
            .flatMap { viewModel, category in
                viewModel.loadUsecase.newsLoad(data: .init(start: viewModel.page, display: 30, query: category))
            }
            .delay(.microseconds(500), scheduler: MainScheduler.asyncInstance)
            .bind(to: self.newsList)
            .disposed(by: self.bag)
        
        input.scroll
            .withUnretained(self)
            .filter { viewModel, index in
                index.row + (index.section * 30) >= (viewModel.page * 30) - 5
            }
            .withLatestFrom(input.categoryTap)
            .withUnretained(self)
            .flatMap { viewModel, category in
                viewModel.page += 1
                return viewModel.loadUsecase.newsLoad(data: .init(start: viewModel.page, display: 30, query: category))
            }
            .withUnretained(self)
            .map { viewModel, newData in
                var dataList = viewModel.newsList.value
                dataList.append(contentsOf: newData)
                return dataList
            }
            .bind(to: self.newsList)
            .disposed(by: self.bag)
    }
}
