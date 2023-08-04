//
//  TamagotchiDetailViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import UIKit

class TamagotchiDetailViewController: UIViewController {

    var tamagotchiName = ""
    var tamagotchiIntroduce = ""
    
    static let identifier = "TamagotchiDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getData(data: Tamagotchi) {
        tamagotchiName = data.name
        tamagotchiIntroduce = data.introduce
        
    }
}
