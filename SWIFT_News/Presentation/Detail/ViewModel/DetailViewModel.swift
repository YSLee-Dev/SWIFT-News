//
//  DetailViewModel.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/18.
//

import Foundation

import RxSwift
import RxCocoa
import RxOptional

class DetailViewModel {
    weak var delegate: DetailVCActionProtocol?
    
    let newsData = BehaviorSubject<NewsData?>(value: nil)
    let bag = DisposeBag()
    
    struct Input {
        let viewDidDisappear: Observable<Void>
    }
    
    struct Output {
        let webLoad: Driver<URL>
        let title: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        self.vcFlow(input: input)
        return Output(
            webLoad: self.newsData
                .filterNil()
                .map { $0.url }
                .asDriver(onErrorDriveWith: .empty()),
            title: self.newsData
                .filterNil()
                .map {"\(String($0.title.prefix(17))) ..."}
                .asDriver(onErrorDriveWith: .empty())
        )
    }
}

private extension DetailViewModel {
    func vcFlow(input: Input) {
        input.viewDidDisappear
            .withUnretained(self)
            .subscribe(onNext: { viewModel, _ in
                viewModel.delegate?.viewDidDisappear()
            })
            .disposed(by: self.bag)
    }
}
