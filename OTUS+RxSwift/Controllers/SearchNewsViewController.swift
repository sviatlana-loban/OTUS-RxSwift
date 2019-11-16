//
//  SearchNewsViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchNewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let disposeBag = DisposeBag()
    let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search news"

        tableView.register(
            UINib(nibName: ArticleTableViewCell.reuseId, bundle: nil),
            forCellReuseIdentifier: ArticleTableViewCell.reuseId
        )
        tableView.tableFooterView = UIView()

        bind()
    }

    func bind() {
        
        let searchInput = searchBar.rx.text.orEmpty
        .filter { $0.count > 2 }
        .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
        .distinctUntilChanged()

        searchInput.subscribe(onNext: { value in
            self.viewModel.requestNews(for: value)
        })
            .disposed(by: disposeBag)

        viewModel.news.bind(to: tableView.rx.items(cellIdentifier: ArticleTableViewCell.reuseId, cellType: ArticleTableViewCell.self)) { row, element, cell in
            cell.setupCell(with: element)
        }.disposed(by: disposeBag)

        _ = Observable
        .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(NewsViewModel.ArticleDescription.self))
        .bind { [unowned self] indexPath, model in
            self.tableView.deselectRow(at: indexPath, animated: false)

            let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
            let articleInfo = ArticleInfo(title: model.title, description: model.description, image: cell.articleImage.image ?? UIImage())

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let labelViewController = storyboard.instantiateViewController(withIdentifier: "labelViewController") as! LabelViewController
            labelViewController.viewModel = NewsDescriptionViewModel(with: articleInfo)

            self.navigationController?.pushViewController(labelViewController, animated: true)
        }
        .disposed(by: disposeBag)

       // let smt = tableItemTapped.subscribe

//        tableView.rx.modelSelected(NewsViewModel.ArticleDescription.self)
//        .subscribe(onNext: { [unowned self] item in
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let labelViewController = storyboard.instantiateViewController(withIdentifier: "labelViewController") as! LabelViewController
//            //let ar
//            //labelViewController.viewModel = NewsDescriptionViewModel(with: ArticleInfo())
//            self.navigationController?.pushViewController(labelViewController, animated: true)
//        }).disposed(by: disposeBag)
    }
}
