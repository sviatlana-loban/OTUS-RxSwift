//
//  NewsApiService.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

class NewsApiService {

    private let networkManager = NetworkManager()

    func search(value: String) -> Observable<[News.Article]> {
        let toDate = Date()
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"

        var dateComponent = DateComponents()
        dateComponent.month = -3
        let fromDate = Calendar.current.date(byAdding: dateComponent, to: toDate) ?? toDate

        let from = df.string(from: toDate)
        let to = df.string(from: fromDate)

        let endpoint = NewsApiEndpoint.everything(value, from, to)
        return networkManager.performRequest(with: endpoint).map {
            let decoder = JSONDecoder()
            let news = try decoder.decode(News.self, from: $0)
            return news.articles
        }
    }

    func search(date: Date) -> Observable<[News.Article]> {
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"

        let from = df.string(from: date)
        let to = df.string(from: date)

        let query = "cats"

        let endpoint = NewsApiEndpoint.everything(query, from, to)
        return networkManager.performRequest(with: endpoint).map {
            let decoder = JSONDecoder()
            let news = try decoder.decode(News.self, from: $0)
            return news.articles
        }
    }
}
