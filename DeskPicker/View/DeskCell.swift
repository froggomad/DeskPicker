//
//  NonShoppingItemCell.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/20/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit

class DeskCell: UICollectionViewCell {
    @IBOutlet weak var deskLbl: UILabel!
    
    var desk: Desk? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        self.deskLbl.text = desk?.name
    }
}
