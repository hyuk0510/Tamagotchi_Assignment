//
//  SetNameViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/06.
//

import UIKit

class SetNameViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    static let identifier = "SetNameViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "대장님 이름 정하기"
        
        designLeftBarButton()
        designRightBarButton()
        designNameTextField()
    }
}

extension SetNameViewController {

    func designNameTextField() {
        nameTextField.placeholder = "대장님 이름을 알려주세요!"
        nameTextField.text = UserDefaults.standard.string(forKey: "User")
        nameTextField.clearButtonMode = .whileEditing
    }
    
    func designLeftBarButton() {
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(closeButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func designRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveName))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc
    func saveName() {
        guard let text = nameTextField.text else {
            return
        }
        UserDefaults.standard.set(text, forKey: "User")
        navigationController?.popViewController(animated: true)
    }
}
