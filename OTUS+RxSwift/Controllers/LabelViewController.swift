//
//  LabelViewController.swift
//  OTUS+RxSwift
//
//  Created by Sviatlana Loban on 11/12/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {

    var info = "default text"
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Info"
        infoLabel.text = info
    }
}
