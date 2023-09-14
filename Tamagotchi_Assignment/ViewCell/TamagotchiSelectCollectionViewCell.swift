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
        configureBorder(view: tamagotchiNameLabel)
        configureText(label: tamagotchiNameLabel)
    }
    
    func designTamagotchiSelectImageView() {
        tamagotchiSelectImageView.contentMode = .scaleAspectFit
    }
    
    func configureTamagotchiSelectCollectionViewCell(row: Int, count: Int) {
        tamagotchiNameLabel.text = TamagotchiInfo.tamagotchi[row].name
        if row > count {
            tamagotchiSelectImageView.image = UIImage(named: "noImage")
        } else {
            tamagotchiSelectImageView.image = UIImage(named: "\(row + 1)-6")
        }
    }
}
