//
//  NewsDescriptionViewModel.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/16/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct ArticleInfo {
    var title: String
    var description: String?
    var image: UIImage
}

class NewsDescriptionViewModel {

    var title: BehaviorSubject<String> = BehaviorSubject(value: "")
    var description: BehaviorSubject<String> = BehaviorSubject(value: "")
    var image: BehaviorSubject<UIImage> = BehaviorSubject(value: UIImage(named: "placeholderImage") ?? UIImage())

    init(with articleDescription: ArticleInfo) {
        title.onNext(articleDescription.title)
        if let articleShort = articleDescription.description { self.description.onNext(articleShort)
        }
        image.onNext(articleDescription.image)
    }


}
