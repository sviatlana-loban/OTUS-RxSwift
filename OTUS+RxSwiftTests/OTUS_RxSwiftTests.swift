//
//  OTUS_RxSwiftTests.swift
//  OTUS+RxSwiftTests
//
//  Created by Sviatlana Loban on 11/18/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import XCTest
@testable import OTUS_RxSwift

class OTUS_RxSwiftTests: XCTestCase {

    var newsViewModelUnderTest: NewsViewModel!

    override func setUp() {
        super.setUp()
        newsViewModelUnderTest = NewsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        newsViewModelUnderTest = nil
        super.tearDown()
    }

    func testDecoding() throws {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "news", ofType: "json")
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        XCTAssertNoThrow(try JSONDecoder().decode(News.self, from: jsonData))

        let news = try JSONDecoder().decode(News.self, from: jsonData)
        XCTAssert(news.articles.count > 0, "Articles array not parsed")
    }

    func test_StartDownload_Performance() {
      measure {
        self.newsViewModelUnderTest.requestNews(for: "Trump")
      }
    }

}
