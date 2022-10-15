//
//  LoginInspectorTests.swift
//  NavigationTests
//
//  Created by Руслан Магомедов on 10.10.2022.
//

import XCTest
@testable import Navigation

final class LoginInspectorTests: XCTestCase {

    let login: String = "test@test.ru"
    let password: String = "123456"
    var isLogined: Bool!

    let inspector = LoginInspectorMock()


    override func setUpWithError() throws {
    }


    func test_checkCredentialWhenEverythingIsTrue() {
        isLogined = false
        inspector.checkCredential(email: login, password: password) { [self] success in
            self.isLogined = success
            XCTAssertTrue(self.isLogined)
        }
    }

    func test_checkCredentialWhenEverythingIsFalse() {
        isLogined = true
        inspector.checkCredential(email: "login", password: "password") { [self] success in
            self.isLogined = success
            XCTAssertFalse(self.isLogined)
        }
    }
}


class LoginInspectorMock: LoginViewControllerDelegate {

    func checkCredential(email: String, password: String, callback: @escaping (Bool) -> Void) {
        CheckerService.shared.checkCredential(email: email, password: password) { success in
            if success {
                callback(true)
            } else {
                callback(false)
            }
        }
    }

    func createUser(email: String, password: String, callback: @escaping (Bool) -> Void) {
    }


}
