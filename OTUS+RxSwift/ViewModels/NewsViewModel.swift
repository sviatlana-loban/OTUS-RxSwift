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

    private(set) var news: BehaviorRelay<[News.Article]> = BehaviorRelay(value: [])

    func requestNews(for value: String) {
        self.newsService.search(value: value)
            .asDriver(onErrorJustReturn: [])
            .drive(news)
            .disposed(by: disposeBag)
    }

//    func requestWeather(at location: CLLocationCoordinate2D) {
//        self.weatherService.weather(at: location)
//            .asDriver(onErrorJustReturn: .empty)
//            .drive(weather)
//            .disposed(by: disposeBag)
//    }

}
