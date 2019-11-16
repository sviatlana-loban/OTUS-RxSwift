//
//  LabelViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LabelViewController: UIViewController {

    var viewModel: NewsDescriptionViewModel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UITextView!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Description"
        print("loaded")
        bind()
    }

    func bind() {
        viewModel.title.bind(to: infoLabel.rx.text).disposed(by: disposeBag)

        viewModel.description.bind(to: newsDescription.rx.text).disposed(by: disposeBag)

        viewModel.image.bind(to: newsImage.rx.image)
    }
}
