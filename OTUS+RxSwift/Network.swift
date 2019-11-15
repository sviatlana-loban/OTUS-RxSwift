//
//  Network.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation

//MARK: Sorting Order Enums
enum SortOptions: String {
    case relevancy // articles more closely related to q come first.
    case popularity // articles from popular sources and publishers come first.
    case publishedAt //newest articles come first.
}

class Network {

    var topHeadLinesUrl = URLComponents(string: "https://newsapi.org/v2/top-headlines?")
    var everythingUrl = URLComponents(string: "https://newsapi.org/v2/everything?")
    var sourcesUrl = URLComponents(string: "https://newsapi.org/v2/sources?") // convenience endpoint for tracking publishers
    //API Query Parameters with sample values
    let search = URLQueryItem(name: "q", value: "uber")
    let fromDate = URLQueryItem(name: "from", value: "2018-07-14")  // needs to be converted to Date
    let toDate = URLQueryItem(name: "to", value: "2018-07-17") // needs to be converted to Date
    let sortBy = URLQueryItem(name: "sortBy", value: SortOptions.publishedAt.rawValue) //should be an enum with options
    let language = URLQueryItem(name: "language", value: "en")
    let country = URLQueryItem(name: "country", value: "us")
    let sourcesName = URLQueryItem(name: "sources", value: "bbc-news")
    let secretAPIKey = URLQueryItem(name: "apiKey", value: "")

    //MARK: Samples EndPoints as per News API suggestions
    //Top headlines in the US
    func topHeadlines() -> URL?  {
        topHeadLinesUrl?.queryItems?.append(country)
        topHeadLinesUrl?.queryItems?.append(secretAPIKey)
        return topHeadLinesUrl?.url
    }


    //Top headlines from BBC News
    func topHeadlinesBBCNews() -> URL? {
        topHeadLinesUrl?.queryItems?.append(sourcesName)
        topHeadLinesUrl?.queryItems?.append(secretAPIKey)
        return topHeadLinesUrl?.url
    }

}
