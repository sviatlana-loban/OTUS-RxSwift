//
//  Endpoint.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Endpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var postParameters: [String: String]? { get }
}
