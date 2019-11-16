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
    let viewModel = NewsViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BBC Top"
        bind()
    }

    func bind() {
        //viewModel.requestTop(for: "bbc")

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
