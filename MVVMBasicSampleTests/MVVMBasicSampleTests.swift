//
//  MVVMBasicSampleTests.swift
//  MVVMBasicSampleTests
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import XCTest
import ReactiveCocoa
import ReactiveSwift
import Result
@testable import MVVMBasicSample

class MVVMBasicSampleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testViewWithoutMutableProperty() {
        let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
        let expectedFullName = "Yoshikuni Kato"

        let userNameViewModel = UserNameViewModel(user: user)
        XCTAssertEqual(userNameViewModel.fullName, expectedFullName)
    }

    func testTableViewWithoutMutableProperty() {
        let users = [
            User(firstName: "Emma", lastName: "Bradley", age: 27, imageName: "yoshikuni"),
            User(firstName: "Alice", lastName: "Baker", age: 51, imageName: "yoshikuni"),
            User(firstName: "Edward", lastName: "Diaz", age: 10, imageName: "yoshikuni")
        ]
        let expectedFullnames = [
            "Emma Bradley",
            "Alice Baker",
            "Edward Diaz"
        ]

        let cellModels: [UsersTableCellModelType] = users.map { (user) -> UsersTableCellModel in
            return UsersTableCellModel(user: user)
        }
        let usersViewModel = UsersViewModel(cellModels: cellModels)

        for (index, cellModel) in usersViewModel.cellModels.enumerated() {
            XCTAssertEqual(cellModel.fullname, expectedFullnames[index])
        }
    }

    func testViewWithMutablePropertyUsingClosure() {

        // for asynchronous test
        let expectation = self.expectation(description: "image set")

        let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
        let userViewModel = UserViewModel(user: user)
        userViewModel.imageDidSetClosure = { (image) in
            XCTAssertNotNil(image, "image not nil")
            expectation.fulfill()
        }
        userViewModel.imageFetchButtonTapped()

        waitForExpectations(timeout: 1.5) { (error) in
            print(error)
        }

    }

    func testViewWithMutablePropertyUsingRAC() {
        // for asynchronous test
        let expectation = self.expectation(description: "image set")

        let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
        let userViewModel = UserViewModelWithRAC(user: user)
        
        userViewModel
            .image
            .signal
            .observeValues { image in
                XCTAssertNotNil(image, "image not nil")
                expectation.fulfill()
        }
        userViewModel
            .imageFetchAction
            .apply(())
            .start()

        waitForExpectations(timeout: 1.5) { (error) in
            print(error)
        }
    }

}
