//
//  SavedTableViewCell.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 24/05/2023.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var savedChampionIdLabel: UILabel!
    
    @IBOutlet weak var savedChampionNameLabel: UILabel!
    
    @IBOutlet weak var savedChampionTitleLabel: UILabel!
    
    @IBOutlet weak var savedChampionImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
