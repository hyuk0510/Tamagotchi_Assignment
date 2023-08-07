//
//  SettingTableViewCell.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/06.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    var row = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        self.tintColor = .black
        self.detailTextLabel?.text = ""
        self.textLabel?.font = .boldSystemFont(ofSize: 13)
        self.backgroundColor = .clear
    }
   
}
