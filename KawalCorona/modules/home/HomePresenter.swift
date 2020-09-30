//
//  HomePresenter.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterDelegate {
    var view: HomeViewDelegate?
    
    func getDashboardData() {
        CovidIndonesiaService.shared.load { (result, error) in
            if let dashboardData = result {
                self.view?.showDashboardData(dashboardData)
            } else if let errorMessage = error {
                self.view?.showError(errorMessage)
            }
        }
    }
    
    func getProvincesData() {
        CovidIndonesiaProvinceService.shared.load { (result, error) in
            if let provincesData = result {
                self.view?.showProvincesData(provincesData)
            } else if let errorMessage = error {
                self.view?.showError(errorMessage)
            }
        }
    }
}
