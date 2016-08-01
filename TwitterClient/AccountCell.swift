//
//  AccountCell.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 7/22/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import AFNetworking

class AccountCell: UITableViewCell {
    
    var user: User?

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
