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
        self.title = "Table 2"
        bind()
    }

    func bind() {
        items.bind(to:
        tableView.rx.items(cellIdentifier: cellIdentifier)) { row, element, cell in
            cell.textLabel?.text = "\(element) \(row)"
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
        .subscribe(onNext: { [unowned self] item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let labelViewController = storyboard.instantiateViewController(withIdentifier: "labelViewController") as! LabelViewController
            labelViewController.info = "Table 2: " + item
            self.navigationController?.pushViewController(labelViewController, animated: true)
        }).disposed(by: disposeBag)
    }
}
