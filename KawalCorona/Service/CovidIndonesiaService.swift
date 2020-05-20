//
//  CovidIndonesiaService.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import Alamofire

protocol CovidIndonesiaDelegate {
    func onLoaded(responseObject: DashboardData)
    func onError(message: String)
}

class CovidIndonesiaService {
    private let delegate: CovidIndonesiaDelegate!
    
    init(delegate: CovidIndonesiaDelegate) {
        self.delegate = delegate
    }
    
    func load() {
        let stringUrl = "https://api.kawalcorona.com/indonesia"
        devPrint("service: url \(stringUrl)")
        
        AF.request(stringUrl).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let jsonDecoder = JSONDecoder()
                    if let data = response.data {
                        let responseObject = try jsonDecoder.decode([DashboardData].self, from: data)
                        
                        if let dashboardData = responseObject.first {
                            self.delegate.onLoaded(responseObject: dashboardData)
                        }
                    }
                } catch let error {
                    devPrint("service: error parsing data -> \(error)")
                    self.delegate.onError(message: "Terjadi kesalahan pada server, harap hubungi administrator.")
                }
            case .failure(let error):
                devPrint("service: connection failure -> \(error)")
                self.delegate.onError(message: "Server timed out")
                break
            }
        }
    }
}
