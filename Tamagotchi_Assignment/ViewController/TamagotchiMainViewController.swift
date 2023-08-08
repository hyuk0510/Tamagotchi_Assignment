//
//  TamagotchiMainViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import UIKit

class TamagotchiMainViewController: UIViewController {

    static let identifier = "TamagotchiMainViewController"
    var tamagotchi = TamagotchiInfo.tamagotchi[TamagotchiInfo.index]
    
    @IBOutlet var barButtonItem: UIBarButtonItem!
    
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var tamagotchiWordLabel: UILabel!
    
    @IBOutlet var tamagotchiImageView: UIImageView!
    
    @IBOutlet var tamagotchiNameLabel: UILabel!
    @IBOutlet var tamagotchiInfoLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        riceTextField.delegate = self
        waterTextField.delegate = self
                
        saveData()
        setBackgroundColor()
        designBarButtonItem()
        setTamagotchiImageView()
        
        designBackImageView()
        designTamagotchiWordLabel()
        
        designTamagotchiNameLabel()
        designTamagotchiInfoLabel()
        
        designRiceTextField()
        designRiceButton()
        
        designWaterTextField()
        designWaterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "\(UserDefaults.standard.string(forKey: "User") ?? "대장")님의 다마고치"
        setTamagotchiWordLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func tappedView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func riceButtonPressed(_ sender: UIButton) {
        plusRice()
    }
    
    @IBAction func waterButtonPressed(_ sender: UIButton) {
        plusWater()
    }
    
    @IBAction func barButtonItemPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: SettingViewController.identifier) as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TamagotchiMainViewController {
    func getData(data: Tamagotchi) {
        tamagotchi = data
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }
    
    func setTamagotchiImageView() {
        let level = tamagotchi.level
        let index = TamagotchiInfo.index
        
        if level == 0 {
            tamagotchiImageView.image = UIImage(named: "\(index + 1)-\(level + 1)")
        } else if level >= 10 {
            tamagotchiImageView.image = UIImage(named: "\(index + 1)-9")
        } else {
            tamagotchiImageView.image = UIImage(named: "\(index + 1)-\(level)")
        }
    }
    
    func setTamagotchiInfoLabel() {
        tamagotchiInfoLabel.text = "LV\(tamagotchi.level) • 밥알 \(tamagotchi.rice)개 • 물방울 \(tamagotchi.water)개"
    }
    
    func designBarButtonItem() {
        barButtonItem.title = ""
        barButtonItem.tintColor = .black
        barButtonItem.image = UIImage(systemName: "person.crop.circle")
    }
    
    func designBackImageView() {
        backImageView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        backImageView.image = UIImage(named: "bubble")
    }
    
    func designTamagotchiWordLabel() {
        tamagotchiWordLabel.font = .boldSystemFont(ofSize: 13)
        tamagotchiWordLabel.textAlignment = .center
    }
    
    func setTamagotchiWordLabel() {
        let user = UserDefaults.standard.string(forKey: "User") ?? "대장"
        let TamagotchiWord = ["\(user)님 배고파요.. 밥주세요..", "\(user)님 목말라요.. 물주세요..", "\(user)님 안녕하세요~!", "\(user)님 졸지 마세요!", "\(user)님 과제 하세요!"]
        tamagotchiWordLabel.text = TamagotchiWord.randomElement()
    }
    
    func designTamagotchiNameLabel() {
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.font = .boldSystemFont(ofSize: 15)
        tamagotchiNameLabel.text = tamagotchi.name
        tamagotchiNameLabel.layer.cornerRadius = 5
        tamagotchiNameLabel.layer.borderWidth = 0.5
    }
    
    func designTamagotchiInfoLabel() {
        tamagotchiInfoLabel.textAlignment = .center
        tamagotchiInfoLabel.font = .boldSystemFont(ofSize: 13)
        setTamagotchiInfoLabel()
    }
    
    func designRiceTextField() {
        riceTextField.placeholder = "밥주세용"
        riceTextField.textAlignment = .center
        riceTextField.clearsOnBeginEditing = false
    }
    
    func designRiceButton() {
        let riceButtonImage = UIImage(systemName: "drop.circle")
        
        riceButton.setImage(riceButtonImage, for: .normal)
        riceButton.setTitle("밥먹기", for: .normal)
        riceButton.layer.borderWidth = 0.5
        riceButton.layer.cornerRadius = 15
    }
    
    func designWaterTextField() {
        waterTextField.placeholder = "물주세용"
        waterTextField.textAlignment = .center
        waterTextField.clearsOnBeginEditing = false
    }
    
    func designWaterButton() {
        let waterButtonImage = UIImage(systemName: "leaf.circle")
        
        waterButton.setImage(waterButtonImage, for: .normal)
        waterButton.setTitle("물먹기", for: .normal)
        waterButton.layer.borderWidth = 0.5
        waterButton.layer.cornerRadius = 15
    }
    
    func saveData() {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(tamagotchi) {
            UserDefaults.standard.setValue(encoded, forKey: "UserTamagotchi\(TamagotchiInfo.index)")
        }
    }
    
    func plusRice() {
        guard let text = riceTextField.text else {
            return
        }
        
        let riceInput = Int(text) ?? 1
        
        if riceInput < 100 {
            tamagotchi.rice += riceInput
        } else {
            let alert = UIAlertController(title: "한 번에 100개 이상 못먹어요!", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }

        saveData()
        setTamagotchiImageView()
        setTamagotchiInfoLabel()
        setTamagotchiWordLabel()
        
        riceTextField.text = nil

    }
    
    func plusWater() {
        guard let text = waterTextField.text else {
            return
        }
        
        let waterInput = Int(text) ?? 1
        
        if waterInput < 50 {
            tamagotchi.water += waterInput
        } else {
            let alert = UIAlertController(title: "한 번에 50개 이상 못마셔요!", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
        
        saveData()
        setTamagotchiImageView()
        setTamagotchiInfoLabel()
        setTamagotchiWordLabel()
        
        waterTextField.text = nil
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
           
                UIView.animate(
                    withDuration: 0.3
                    , animations: {
                        self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                    }
                )
            }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
}

extension TamagotchiMainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let input = textField.text else {
            return false
        }
        
        if Int(input) != nil {
            if textField == riceTextField {
                plusRice()
                
            } else if textField == waterTextField {
                plusWater()
            }
            textField.resignFirstResponder()
        } else {
            let alert = UIAlertController(title: "숫자만 입력해주세요.", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(cancel)
            
            textField.text = nil
            
            present(alert, animated: true)
        }
        
        return true
    }
}
