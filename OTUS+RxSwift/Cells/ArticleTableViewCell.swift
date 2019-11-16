//
//  ArticleTableViewCell.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/16/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var publisher: UILabel!
    @IBOutlet var articleImage: UIImageView!

    static let reuseId = String(describing: ArticleTableViewCell.self)

    let viewModel: ArticleCellViewModel = ArticleCellViewModel()
    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.image.asObservable().bind(to: articleImage.rx.image).disposed(by: self.disposeBag)
    }

    func setupCell(with articleDescription: NewsViewModel.ArticleDescription) {
        self.title.text = articleDescription.title
        self.publisher.text = articleDescription.publisher
        self.articleImage.image = UIImage(named: "newsPlaceholder")
        viewModel.downloadImage(url: articleDescription.imageUrl)
    }

}


