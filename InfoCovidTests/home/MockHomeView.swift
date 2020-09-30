//
//  MockHomeView.swift
//  InfoCovidTests
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

@testable import Info_Covid

class MockHomeView: HomeVC {
    var showHomeDataCalled: Bool = false
    
    override func showHomeData(_ data: HomeData) {
        showHomeDataCalled = true
    }
}
