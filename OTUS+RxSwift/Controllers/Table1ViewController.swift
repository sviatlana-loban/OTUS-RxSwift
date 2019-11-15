//
//  Table1ViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Table1ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    let cellIdentifier = "table1Cell"
    let viewModel = NewsViewModel()

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
        self.title = "Table 1"
        bind()
    }

    func bind() {
        let searchInput = Observable.just("Trump")

        searchInput.subscribe(onNext: { value in
            self.viewModel.requestNews(for: value)
        })
            .disposed(by: disposeBag)

        viewModel.news.bind(to:
        tableView.rx.items(cellIdentifier: cellIdentifier)) { row, element, cell in
            cell.textLabel?.text = "\(element.title)"
            cell.detailTextLabel?.text = "\(element.publisher)"
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
        .subscribe(onNext: { [unowned self] item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let labelViewController = storyboard.instantiateViewController(withIdentifier: "labelViewController") as! LabelViewController
            labelViewController.info = item
            self.navigationController?.pushViewController(labelViewController, animated: true)
        }).disposed(by: disposeBag)
    }
}
