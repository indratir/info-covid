//
//  CovidIndonesiaService.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import Alamofire

class CovidIndonesiaService {
    
    static let shared = CovidIndonesiaService()
    lazy var stringUrl = "https://api.kawalcorona.com/indonesia"
    
    func load(completion: @escaping (_ result: DashboardData?, _ errorMessage: String?) -> Void) {
        devPrint("service: url \(stringUrl)")
        
        AF.request(stringUrl).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let jsonDecoder = JSONDecoder()
                    if let data = response.data {
                        let responseObject = try jsonDecoder.decode([DashboardData].self, from: data)
                        
                        if let dashboardData = responseObject.first {
                            completion(dashboardData, nil)
                        }
                    }
                } catch let error {
                    devPrint("service: error parsing data -> \(error)")
                    completion(nil, "Terjadi kesalahan pada server, harap hubungi administrator.")
                }
            case .failure(let error):
                devPrint("service: connection failure -> \(error)")
                completion(nil, "Server timed out")
            }
        }
    }
}
