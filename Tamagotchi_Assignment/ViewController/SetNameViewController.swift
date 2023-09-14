//
//  SetNameViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/06.
//

import UIKit

class SetNameViewController: UIViewController {
    
    enum NameError: Error {
        case isNotValidateLength
        case isNotValidateInput
    }
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "대장님 이름 정하기"
        
        setBackgroundColor()
        designLeftBarButton()
        designRightBarButton()
        designNameTextField()
    }
}

extension SetNameViewController {
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }

    func designNameTextField() {
        nameTextField.placeholder = "대장님 이름을 알려주세요!"
        nameTextField.text = UserDefaults.standard.string(forKey: "User") ?? "대장"
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
        
        do {
            let _ = try validationUserInputError(text: text)
        } catch {
            switch error {
            case NameError.isNotValidateLength:
                showAlert(message: "2글자 이상 6글자 이하 입력해주세요")

            case NameError.isNotValidateInput: showAlert(message: "첫 글자 공백 입력은 불가능합니다.")
                
            default: showAlert(message: "알 수 없는 오류입니다.")
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("UserName"), object: nil, userInfo: ["UserName": text])
        navigationController?.popViewController(animated: true)
    }
    
    func validationUserInputError(text: String) throws -> Bool {
        
        guard !text.hasPrefix(" ") else {
            throw NameError.isNotValidateInput
        }
        
        guard text.count >= 2 && text.count <= 6 else {
            throw NameError.isNotValidateLength
        }
        
        return true
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "잘못된 입력입니다", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
