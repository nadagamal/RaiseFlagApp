//
//  UserCell.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/1/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userAgeLbl: UILabel!
    @IBOutlet weak var userCountryLbl: UILabel!
    @IBOutlet weak var userStatusBtn: UIButton!
    
    @IBOutlet weak var settingsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
