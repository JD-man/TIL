//
//  UserTextFieldTest.swift
//  SeSAC_Week23UITests
//
//  Created by JD_MacMini on 2022/02/28.
//

import XCTest

class UserTextFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTextField() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["First"].tap()
        app.textFields["First"].typeText("우왕굳")
        
        app.textFields["Second"].tap()
        app.textFields["Second"].typeText("우왕굳2")
        
        app.textFields["Third"].tap()
        app.textFields["Third"].typeText("우왕굳2")
        
        
        
    }
}
