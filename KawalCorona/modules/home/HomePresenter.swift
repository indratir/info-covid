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
    lazy var data = HomeData(dashboard: nil, provinces: nil)
    
    func getHomeData() {
        CovidIndonesiaService.shared.load { (result, error) in
            if let errorMessage = error {
                self.view?.showError(errorMessage)
                return
            } else {
                self.data.dashboard = result
            }
        }
        
        CovidIndonesiaProvinceService.shared.load { (result, error) in
            if let errorMessage = error {
                self.view?.showError(errorMessage)
                return
            } else {
                self.data.provinces = result
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.view?.showHomeData(self.data)
        })
    }
}
