//
//  SeSAC_Week23Tests.swift
//  SeSAC_Week23Tests
//
//  Created by JD_MacMini on 2022/02/28.
//

import XCTest
@testable import SeSAC_Week23

class SeSAC_Week23Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.loadViewIfNeeded()
        vc.firstTextField.text = "해위이이이이잉히이힝히이잉"
        
        let count = vc.calculateTextFieldTextCount()
        
        XCTAssertEqual(count, 13)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
