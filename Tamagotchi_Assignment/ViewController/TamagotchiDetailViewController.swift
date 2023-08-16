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
    var imageName = ""
    var row = 0
        
    @IBOutlet var backView: UIView!
    
    @IBOutlet var tamagotchiDetailImageView: UIImageView!
    
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    @IBOutlet var tamagotchiIntroduceTextView: UITextView!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tamagotchiIntroduceTextView.delegate = self
        
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
        UserDefaults.standard.set(true, forKey: "isSelected")
        UserDefaults.standard.set(row, forKey: "TamagotchiIndex")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: TamagotchiMainViewController.identifier) as! TamagotchiMainViewController
        let nav = UINavigationController(rootViewController: vc)
        let index = UserDefaults.standard.integer(forKey: "TamagotchiIndex")
//        vc.index = row
        if UserDefaults.standard.bool(forKey: "isChanged") {
            if let savedData = UserDefaults.standard.object(forKey: "UserTamagotchi\(row)") as? Data {
                let decoder = JSONDecoder()
                
                if let savedObject = try? decoder.decode(Tamagotchi.self, from: savedData) {
                    vc.getData(data: savedObject)
                }
            }
        } else {
            
        }
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension TamagotchiDetailViewController {
    
    func getData(data: Tamagotchi) {

        tamagotchiName = data.name
        tamagotchiIntroduce = data.introduce
        
        if row > 2 {
            imageName = "noImage"
        } else {
            imageName = "\(row + 1)-6"
        }
    }
    
    func setData() {
        
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
    
    func designCancelButton() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.backgroundColor = .systemGray5
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.maskedCorners = .layerMinXMaxYCorner
        cancelButton.layer.cornerRadius = 10
    }

    func designStartButton() {
        var buttonTitle = ""
        if UserDefaults.standard.bool(forKey: "isChanged") == false {
            buttonTitle = "시작하기"
        } else {
            buttonTitle = "변경하기"
        }

        startButton.setTitle(buttonTitle, for: .normal)
        startButton.backgroundColor = .clear
    }
}

extension TamagotchiDetailViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }
    func designIntroduceTextView() {
        tamagotchiIntroduceTextView.textAlignment = .center
        tamagotchiIntroduceTextView.font = .boldSystemFont(ofSize: 13)
        tamagotchiIntroduceTextView.backgroundColor = .clear
        tamagotchiIntroduceTextView.tintColor = .clear
    }
}
