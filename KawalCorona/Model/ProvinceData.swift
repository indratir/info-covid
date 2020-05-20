//
//  ProvinceData.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

class ProvinceData: Codable {
    var province: String?
    var recovered: Int?
    var positive: Int?
    var died: Int?
    
    private enum CodingKeys: String, CodingKey {
        case province = "Provinsi"
        case recovered = "Kasus_Semb"
        case positive = "Kasus_Posi"
        case died = "Kasus_Meni"
    }
}
