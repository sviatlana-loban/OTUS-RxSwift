//
//  NetwrokManager.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/15/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import RxSwift

class NetworkManager {

    func performRequest(with endpoint: Endpoint) -> Observable<Data> {
        var request = buildRequest(with: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return URLSession.shared.rx.data(request: request)
    }

    private func buildRequest(with endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)

        if var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: true),
            let parameters = endpoint.queryParameters {

            let queryItems = parameters.map { URLQueryItem(name: $0.0, value: $0.1) }
            components.queryItems = queryItems
            request.url = components.url
        }

        if case .POST = endpoint.method, let postParameters = endpoint.postParameters {
            let jsonData = try! JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }

        return request
    }

}
