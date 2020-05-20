//
//  FooterCell.swift
//  KawalCorona
//
//  Created by Indra Tirta Nugraha on 10/05/20.
//  Copyright © 2020 Indra Tirta Nugraha. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    @IBOutlet var labelFootnote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        labelFootnote.text = "Data diambil dari website https://kawalcorona.com\nIndra Tirta Nugraha © 2020"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
