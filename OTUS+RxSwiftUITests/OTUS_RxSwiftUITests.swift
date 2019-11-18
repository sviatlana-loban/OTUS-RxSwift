//
//  OTUS_RxSwiftUITests.swift
//  OTUS+RxSwiftUITests
//
//  Created by Sviatlana Loban on 11/18/19.
//  Copyright © 2019 SLoban. All rights reserved.
//

import XCTest

class OTUS_RxSwiftUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLabelTextOnDatePickerChange() {
        // UI tests must launch the application that they test.

        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars.buttons["Cats news"].tap()

        let datePickersQuery = app.datePickers

        let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let monthText = formatter.string(from: Date())

        datePickersQuery.pickerWheels[String(dateComponent.year!)].adjust(toPickerWheelValue: "2019")
        datePickersQuery.pickerWheels[monthText].adjust(toPickerWheelValue: "November")
        datePickersQuery.pickerWheels[String(dateComponent.day!)].adjust(toPickerWheelValue: "18")

        let date18Label = app.staticTexts["Date: 18 November 2019"]
        XCTAssertTrue(date18Label.exists)

        datePickersQuery.pickerWheels["18"].adjust(toPickerWheelValue: "17")
        let date17Label = app.staticTexts["Date: 17 November 2019"]
        XCTAssertTrue(date17Label.exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
