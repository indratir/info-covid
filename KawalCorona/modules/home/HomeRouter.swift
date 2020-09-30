//
//  HomeRouter.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 30/09/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

class HomeRouter {
    static func createModule() -> HomeVC {
        let presenter: HomePresenterDelegate = HomePresenter()
        let view = HomeVC()
        
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
