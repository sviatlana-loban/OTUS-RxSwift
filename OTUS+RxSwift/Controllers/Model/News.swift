//
//  News.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation

struct News: Codable {
    let status: String?
    let totalResults: Int?
    struct Article: Codable {
        let source: Source
        let author: String?
        let title: String?
        let description: String?
        let url: URL?
        let urlToImage: URL?
        //let publishedAt: Date

        struct Source: Codable {
            let id: String?
            let name: String?
        }
    }

    let articles: [Article]

    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
