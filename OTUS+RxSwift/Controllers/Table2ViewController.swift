//
//  Table2ViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class Table2ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    let cellIdentifier = "table2Cell"

    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item",
        "Fourth Item",
        "Fifth Item",
        "Sixth Item",
        "Seventh Item",
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }

    func bind() {
        items.bind(to:
        tableView.rx.items(cellIdentifier: cellIdentifier)) { row, element, cell in
            cell.textLabel?.text = "\(element) \(row)"
        }.disposed(by: disposeBag)
    }

//    private func setupTableViewBinding() {
//
//        viewModel.dataSource
//            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) {  row, element, cell in
//                cell.textLabel?.text = "\(element) \(row)"
//            }
//            .addDisposableTo(disposeBag)
//    }
}
