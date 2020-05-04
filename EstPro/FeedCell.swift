//
//  FeedCell.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 24.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var homeSizeLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var heatingLabel: UILabel!
    @IBOutlet weak var buildingAgeLabel: UILabel!
    @IBOutlet weak var floorLocLabel: UILabel!
    @IBOutlet weak var numberOfFloorLoc: UILabel!
    @IBOutlet weak var balconyLabel: UILabel!
    @IBOutlet weak var estImageView: UIImageView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
