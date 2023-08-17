//
//  MainVC.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import SnapKit
import RxSwift

final class MainVC: UIViewController {
    let tableView = MainTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attribute()
        self.layout()
    }
}

private extension MainVC {
    func attribute() {
        self.title = "NEWS"
        self.view.backgroundColor = .systemBackground
    }
    
    func layout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
