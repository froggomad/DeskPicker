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
    #warning("Assign this in VC didSelectItemAt method")
//    @IBAction func touchedMe(_ sender: UIButton) {
//        self.delegate?.ohYeahYouTouchedIt(cell: self)
//    }
    
    
    //weak var delegate: TouchTheDesk?
    
    var desk: Desk? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        self.deskLbl.text = desk?.name
    }
}
