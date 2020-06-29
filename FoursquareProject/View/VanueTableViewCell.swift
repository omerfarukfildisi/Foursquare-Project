//
//  VanueTableViewCell.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 26.06.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation
import UIKit
class VanueTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var adressTextView: UITextView!
    
    

    func setCell(name: String, adress: String){
        nameLabel.text = name
        adressTextView.text = adress
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
