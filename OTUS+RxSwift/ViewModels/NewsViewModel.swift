//
//  NewsViewModel.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NewsViewModel {
    private let disposeBag = DisposeBag()
    private let newsService = NewsApiService()

    private(set) var news: BehaviorRelay<[ArticleViewModel]> = BehaviorRelay(value: [])

    func requestNews(for value: String) {
        self.newsService.search(value: value)
            .map{ articles in
                var articleDescriptions = [ArticleViewModel]()
                for article in articles {
                    articleDescriptions.append(ArticleViewModel(title: article.title ?? "", publisher: article.source.name ?? ""))
                }
                return articleDescriptions
        }
            .asDriver(onErrorJustReturn: [])
//            .map{News.Article -> ArticleViewModel article in return ArticleViewModel(title: $0., publisher: <#T##String#>) }
            .drive(news)
            .disposed(by: disposeBag)
    }
}
