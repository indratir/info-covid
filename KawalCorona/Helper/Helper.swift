//
//  Helper.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import Foundation

extension Date {
    var greetingCaption: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        
        if hour >= 4 && hour < 10 {
            return "Selamat Pagi,"
        } else if hour >= 10 && hour < 14 {
            return "Selamat Siang,"
        } else if hour >= 14 && hour < 17 {
            return "Selamat Sore,"
        } else if hour >= 17 && hour < 19 {
            return "Selamat Petang,"
        } else {
            return "Selamat Malam,"
        }
    }
}

enum PatientType: String {
    case recovered
    case positive
    case died
}

protocol MainViewDelegate {
    func changeProvinceData(type: PatientType, index: Int)
}
