//
//  ProvinceTabView.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

class ProvinceTabView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    var delegate: MainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ProvinceTabView", owner: self, options: nil)
        self.containerView.frame = self.frame
        addSubview(containerView)
    }
    
    @IBAction func changeTab(_ sender: UISegmentedControl) {
        var type: PatientType = .recovered
        
        if sender.selectedSegmentIndex == 1 {
            type = .positive
        } else if sender.selectedSegmentIndex == 2 {
            type = .died
        } else {
            type = .recovered
        }
        
        delegate?.changeProvinceData(type: type, index: sender.selectedSegmentIndex)
    }
}
