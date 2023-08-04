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
    var index = 0
    
    static let identifier = "TamagotchiDetailViewController"
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var tamagotchiDetailImageView: UIImageView!
    
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    @IBOutlet var tamagotchiIntroduceTextView: UITextView!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.1764706075, green: 0.1764706075, blue: 0.1764706075, alpha: 0.5)
        designBackView()
        designNameLabel()
        designIntroduceTextView()
        designCancelButton()
        designStartButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setData()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        //let vc
    }
}

extension TamagotchiDetailViewController {
    func getData(data: Tamagotchi) {
        tamagotchiName = data.name
        tamagotchiIntroduce = data.introduce
    }
    
    func setData() {
        let row = index
        var imageName = ""
        
        if row > 2 {
            imageName = "noImage"
        } else {
            imageName = "\(row + 1)-6"
        }
        
        tamagotchiDetailImageView.image = UIImage(named: imageName)
        tamagotchiDetailImageView.contentMode = .scaleAspectFit
        
        tamagotchiNameLabel.text = tamagotchiName
        tamagotchiIntroduceTextView.text = tamagotchiIntroduce
    }
    
    func designBackView() {
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }
    
    func designNameLabel() {
        tamagotchiNameLabel.font = .boldSystemFont(ofSize: 13)
        tamagotchiNameLabel.layer.cornerRadius = 5
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.layer.borderWidth = 1
    }
    
    func designIntroduceTextView() {
        tamagotchiIntroduceTextView.textAlignment = .center
        tamagotchiIntroduceTextView.font = .boldSystemFont(ofSize: 13)
        tamagotchiIntroduceTextView.backgroundColor = .clear
    }
    
    func designCancelButton() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "hi", size: 13)
        cancelButton.backgroundColor = .systemGray5
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.maskedCorners = .layerMinXMaxYCorner
        cancelButton.layer.cornerRadius = 10
    }
    
    func designStartButton() {
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        startButton.backgroundColor = .clear
    }
}
