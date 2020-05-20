//
//  ProvinceDataCell.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

class ProvinceDataCell: UITableViewCell {

    @IBOutlet var labelValue: UILabel!
    @IBOutlet var labelProvinceName: UILabel!
    var data: ProvinceAttribute?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        labelValue.showAnimatedSkeleton()
        labelProvinceName.showAnimatedSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ provinceAttribute: ProvinceAttribute?, type: PatientType) {
        data = provinceAttribute
        
        if let data = data {
            labelProvinceName.hideSkeleton()
            labelValue.hideSkeleton()
            
            labelProvinceName.text = data.attributes?.province
            
            switch type {
            case .recovered:
                labelValue.text = "\(data.attributes?.recovered ?? 0)"
            case .positive:
                labelValue.text = "\(data.attributes?.positive ?? 0)"
            case .died:
                labelValue.text = "\(data.attributes?.died ?? 0)"
            }
        } else {
            labelValue.showAnimatedSkeleton()
            labelProvinceName.showAnimatedSkeleton()
        }
    }
    
}
