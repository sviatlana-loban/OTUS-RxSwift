//
//  NewsApiService.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import CoreLocation

enum NewsApiEndpoint: Endpoint {

    static let baseUrl = "https://newsapi.org/v2"
    static let apiKey = "f8453102cf7a4c79880c1de07fcfd2be"

    case topHeadLines(_ country: String)
    case sources(_ source: String)
    case everything(_ value: String, _ from: String, _ to: String)

    var path: String {
        switch self {
        case .topHeadLines:
            return "/top-headlines?"
        case .sources:
            return "/sources?"
        case .everything:
            return "/everything?"
        }
    }

    var method: HTTPMethod {
        return .GET
    }

    var queryParameters: [String: String]? {
        switch self {
        case .everything(let value, let from, let to):
            return [ "q": value, "from": from, "to": to].merging(requiredQueryParameters) { (current, _) in current }
        case .sources(let source):
            return [ "sources": source ].merging(requiredQueryParameters) { (current, _) in current }
        case .topHeadLines(let country):
            return [ "country": country ].merging(requiredQueryParameters) { (current, _) in current }
        }
    }

    var postParameters: [String: String]? {
        return nil
    }

    private var requiredQueryParameters: [String: String] {
        return [
            "apiKey": NewsApiEndpoint.apiKey
        ]
    }

    var url: URL {
        return URL(string: "\(NewsApiEndpoint.baseUrl)\(path)")!
    }

}
