//
//  HomeTests.swift
//  InfoCovidTests
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import XCTest
@testable import Info_Covid

class HomeTests: XCTestCase {
    
    var presenter: HomePresenter?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let view = MockHomeView()
        presenter = HomePresenter()
        
        presenter?.view = view
        view.presenter = presenter
        
        view.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateModule() {
        XCTAssertNotNil(HomeRouter.createModule())
    }
    
    func testGetHomeData() {
        let expectation = XCTestExpectation(description: "Get Home Data")
        
        presenter?.getHomeData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if let view = self.presenter?.view as? MockHomeView {
                XCTAssertTrue(view.showHomeDataCalled)
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
