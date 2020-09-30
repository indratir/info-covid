//
//  MockHomeView.swift
//  InfoCovidTests
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

@testable import Info_Covid

class MockHomeView: HomeVC {
    var showDashboardDataCalled = false
    var showProvincesDataCalled = false
    
    override func showDashboardData(_ dashboardData: DashboardData) {
        showDashboardDataCalled = true
    }
    
    override func showProvincesData(_ provincesData: [ProvinceAttribute]) {
        showProvincesDataCalled = true
    }
}
