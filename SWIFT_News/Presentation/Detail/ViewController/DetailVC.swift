//
//  DetailVC.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/18.
//

import UIKit

import WebKit

import Then
import SnapKit

import RxSwift
import RxCocoa

class DetailVC: UIViewController {
    let indicatorView = UIActivityIndicatorView().then {
        $0.color = .label
    }
    
    lazy var webView = WKWebView().then {
        $0.navigationDelegate = self
        $0.backgroundColor = .systemBackground
        $0.allowsLinkPreview = false
    }
    
    let viewModel: DetailViewModel
    let bag = DisposeBag()
    
    let viewDidDisappear = PublishSubject<Void>()
    
    init(
        viewModel: DetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.bind()
        self.attribute()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewDidDisappear.onNext(Void())
        super.viewDidDisappear(animated)
    }
}

extension DetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
    }
}

private extension DetailVC {
    func attribute() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    func layout() {
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.webView.addSubview(self.indicatorView)
        self.indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind() {
        let input = DetailViewModel.Input(viewDidDisappear: self.viewDidDisappear)
        let output = self.viewModel.transform(input: input)
        
        output.webLoad
            .drive(self.rx.webLoad)
            .disposed(by: self.bag)
        
        output.title
            .drive(self.rx.titleSet)
            .disposed(by: self.bag)
    }
}

extension Reactive where Base: DetailVC {
    var webLoad: Binder<URL> {
        return Binder(base) { base, url in
            let request = URLRequest(url: url)
            base.webView.load(request)
        }
    }
    
    var titleSet: Binder<String> {
        return Binder(base) { base, title in
            base.title = title
        }
    }
}
