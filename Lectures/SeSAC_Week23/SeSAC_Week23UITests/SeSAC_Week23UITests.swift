//
//  SeSAC_Week23UITests.swift
//  SeSAC_Week23UITests
//
//  Created by JD_MacMini on 2022/02/28.
//

import XCTest

class SeSAC_Week23UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons["First"].tap()
        app.buttons["Second"].tap()
    }
    
//    func testViewControllerTransition() throws {
//        let app = XCUIApplication()
//        app.launch()
//        app.buttons["First"].tap()
//        app.buttons["Button"].tap()
//    }
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
