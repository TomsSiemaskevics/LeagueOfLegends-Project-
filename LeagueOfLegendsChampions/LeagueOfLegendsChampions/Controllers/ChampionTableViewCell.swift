//
//  ChampionTableViewCell.swift
//  LeagueOfLegendsChampions
//
//  Created by toms.siemaskevics on 23/05/2023.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var championsImageView: UIImageView!
    
    @IBOutlet weak var championsIdLabel: UILabel!
    
    @IBOutlet weak var championsNameLabel: UILabel!
    
    @IBOutlet weak var championsTitleLabel: UILabel!
    
    override func awakeFromNib() {
       super.awakeFromNib()
       selectionStyle = .none
   }
    
   

}
