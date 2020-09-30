//
//  SummaryCell.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit
import SkeletonView

class SummaryCell: UITableViewCell {

    @IBOutlet var cardRecovered: UIView!
    @IBOutlet var cardPositive: UIView!
    @IBOutlet var cardDied: UIView!
    @IBOutlet var labelRecoveredValue: UILabel!
    @IBOutlet var labelPositiveValue: UILabel!
    @IBOutlet var labelDiedValue: UILabel!
    var data: DashboardData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardRecovered.skeletonCornerRadius = Float(cardRecovered.layer.cornerRadius)
        cardPositive.skeletonCornerRadius = Float(cardPositive.layer.cornerRadius)
        cardDied.skeletonCornerRadius = Float(cardDied.layer.cornerRadius)
        
        cardRecovered.showAnimatedSkeleton()
        cardPositive.showAnimatedSkeleton()
        cardDied.showAnimatedSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dashboardData: DashboardData?) {
        self.data = dashboardData
        
        if let data = self.data {
            cardRecovered.hideSkeleton()
            cardPositive.hideSkeleton()
            cardDied.hideSkeleton()
            
            labelRecoveredValue.text = data.sembuh
            labelPositiveValue.text = data.positif
            labelDiedValue.text = data.meninggal
        } else {
            cardRecovered.showAnimatedSkeleton()
            cardPositive.showAnimatedSkeleton()
            cardDied.showAnimatedSkeleton()
        }
    }
}
