//
//  EstadosTableViewCell.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/5/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit

class EstadosTableViewCell: UITableViewCell {

    @IBOutlet weak var estado: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
