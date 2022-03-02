//
//  LoginViewControllerTests.swift
//  SeSAC_Week23Tests
//
//  Created by JD_MacMini on 2022/03/02.
//

import XCTest
@testable import SeSAC_Week23

class LoginViewControllerTests: XCTestCase {
    
    // system under test
    var sut: LoginViewController!

    override func setUpWithError() throws {
        sut = (UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

//    //BDD(Behavior Driven Development) : Given, When, Then
//    //TDD(Test Driven Development: AAA
//    func testLoginViewController_ValidID_ReturnTrue() throws {
//        // Given, Arrange
//        sut.idTextField.text = "jd@jd.com"
//        // When, Act
//        let isValidID = sut.isValidID()
//        // Then, Assert
//        XCTAssertTrue(isValidID, "@가 없거나 6글자 미만이라서 테스트 실패일 가능성이 있음")
//    }
//    
//    func testLoginViewController_InvalidPassword_ReturnFalse() throws {
//        sut.idTextField.text = "jd@jd.com"
//        sut.passwordTextField.text = "1234"
//        let isInvalidPassword = sut.isValidPassword()
//        XCTAssertFalse(isInvalidPassword, "패스워드 로직 확인")
//    }
//    
//    func testLoginViewController_idTextField_ReturnNil() throws {
//        sut.idTextField = nil
//        let isTextFieldNil = sut.idTextField
//        XCTAssertNil(isTextFieldNil)
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
