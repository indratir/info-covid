//
//  ProvinceAttribute.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

class ProvinceAttribute: Codable {
    var attributes: ProvinceData?
    
    private enum CodingKeys: String, CodingKey {
        case attributes
    }
}
