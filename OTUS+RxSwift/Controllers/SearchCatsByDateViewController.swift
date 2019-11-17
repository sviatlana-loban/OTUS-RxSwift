//
//  SearchCatsByDateViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchCatsByDateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    let disposeBag = DisposeBag()
    let viewModel = NewsViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cats by date"

        tableView.register(
            UINib(nibName: ArticleTableViewCell.reuseId, bundle: nil),
            forCellReuseIdentifier: ArticleTableViewCell.reuseId
        )
        tableView.tableFooterView = UIView()
        datePicker.maximumDate = Date()

        bind()
    }

    func bind() {

        let _ = datePicker.rx.date.bind(to: viewModel.date)

        viewModel.date
            .asDriver(onErrorJustReturn: Date())
            .map { d -> String in
                let df = DateFormatter()
                df.dateFormat = "dd MMMM YYYY"
                return "Date: " + df.string(from: d)
            }
        .drive(dateLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.date.asObservable().subscribe(onNext: { date in
            self.viewModel.requestNews(on: date)
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
            let newsDescriptionViewController = storyboard.instantiateViewController(withIdentifier: "newsDescriptionViewController") as! NewsDescriptionViewController
            newsDescriptionViewController.viewModel = NewsDescriptionViewModel(with: articleInfo)

            self.navigationController?.pushViewController(newsDescriptionViewController, animated: true)
        }
        .disposed(by: disposeBag)
    }
}
