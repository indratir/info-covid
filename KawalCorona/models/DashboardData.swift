//
//  DashboardData.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

class DashboardData: Codable {
    var name: String?
    var positif: String?
    var sembuh: String?
    var meninggal: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case positif
        case sembuh
        case meninggal
    }
}
