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

    struct ArticleDescription {
        var title: String
        var publisher: String
        var description: String?
        var imageUrl: URL?
    }

    private let disposeBag = DisposeBag()
    private let newsService = NewsApiService()

    private(set) var news: BehaviorRelay<[ArticleDescription]> = BehaviorRelay(value: [])

    var date: BehaviorRelay<Date> = BehaviorRelay(value: Date())

    func requestNews(for value: String) {
        self.newsService.search(value: value)
            .map{ articles in
                var articleDescriptions = [ArticleDescription]()
                for article in articles {
                    articleDescriptions.append(ArticleDescription(title: article.title ?? "", publisher: article.source.name ?? "", description: article.description, imageUrl: article.urlToImage))
                }
                return articleDescriptions
            }
            .asDriver(onErrorJustReturn: [])
            .drive(news)
            .disposed(by: disposeBag)
    }

    func requestNews(on d: Date) {
        self.newsService.search(date: d)
            .map{ articles in
                var articleDescriptions = [ArticleDescription]()
                for article in articles {
                    articleDescriptions.append(ArticleDescription(title: article.title ?? "", publisher: article.source.name ?? "", description: article.description, imageUrl: article.urlToImage))
                }
                return articleDescriptions
            }
            .asDriver(onErrorJustReturn: [])
            .drive(news)
            .disposed(by: disposeBag)
    }

}
