//
//  TamagotchiSelectCollectionViewCell.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import UIKit

class TamagotchiSelectCollectionViewCell: UICollectionViewCell {

    @IBOutlet var tamagotchiSelectImageView: UIImageView!
    
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    static let identifier = "TamagotchiSelectCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designTamagotchiNameLabel()
        designTamagotchiSelectImageView()
    }
    
    func designTamagotchiNameLabel() {
        tamagotchiNameLabel.font = .boldSystemFont(ofSize: 13)
        tamagotchiNameLabel.layer.cornerRadius = 5
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.layer.borderWidth = 1
    }
    
    func designTamagotchiSelectImageView() {
        tamagotchiSelectImageView.contentMode = .scaleAspectFit
    }
    
    func configureTamagotchiSelectCollectionViewCell() {
        let row = tamagotchiSelectImageView.tag
        tamagotchiNameLabel.text = TamagotchiInfo.tamagotchi[row].name
        if TamagotchiInfo.tamagotchi[row].name == "준비중이에요" {
            tamagotchiSelectImageView.image = UIImage(named: "noImage")
        } else {
            tamagotchiSelectImageView.image = UIImage(named: "\(row + 1)-6")
        }
    }
}

//check
