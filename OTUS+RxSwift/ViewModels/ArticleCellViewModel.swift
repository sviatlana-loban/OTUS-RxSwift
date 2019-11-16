//
//  ArticleCellViewModel.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/16/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ArticleCellViewModel {

    let image : BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)

    func downloadImage(url: URL?) {
        guard let url = url else {
            return
        }
        URLSession.shared.dataTask( with: url, completionHandler: { (data, _, _) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image.accept(UIImage(data: data))
                }
            }
        }
        ).resume()
    }
}
