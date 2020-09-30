//
//  HomeDelegate.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

protocol HomePresenterDelegate: AnyObject {
    var view: HomeViewDelegate? {get set}
    func getDashboardData()
    func getProvincesData()
}

protocol HomeViewDelegate: AnyObject {
    var presenter: HomePresenterDelegate? {get set}
    func showDashboardData(_ dashboardData: DashboardData)
    func showProvincesData(_ provincesData: [ProvinceAttribute])
    func showError(_ message: String)
}
