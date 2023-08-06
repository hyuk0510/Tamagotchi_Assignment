//
//  SettingViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/06.
//

import UIKit

enum Setting: String, CaseIterable {
    case setMyName = "내 이름 설정하기"
    case changeTamagotchi = "다마고치 변경하기"
    case resetData = "데이터 초기화"
}

class SettingViewController: UIViewController {

    static let identifier = "SettingViewController"
    let imageName = ["pencil", "moon.fill", "arrow.clockwise"]
    let setting = Setting.allCases
    
    @IBOutlet var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        connectCell()

        title = "설정"
        
        setLeftBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingTableView.reloadData()
    }
}

extension SettingViewController {
    func setLeftBarButton() {
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(backButtonPressed))
    }
    
    @objc
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func connectCell() {
        let nib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)

        settingTableView.register(nib, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        
        let row = indexPath.row
        
        cell.row = row
        cell.textLabel?.text = setting[row].rawValue
        if cell.textLabel?.text == "내 이름 설정하기" {
            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "User")
        }
        cell.imageView?.image = UIImage(systemName: imageName[row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        switch setting[row] {
        case .setMyName:
            let vc = storyboard?.instantiateViewController(identifier: SetNameViewController.identifier) as! SetNameViewController
            
            navigationController?.pushViewController(vc, animated: true)
        case .changeTamagotchi:
            let vc = storyboard?.instantiateViewController(identifier: SelectViewController.identifier) as! SelectViewController
            
            UserDefaults.standard.set(true, forKey: "isChanged")
            
            navigationController?.pushViewController(vc, animated: true)
        case .resetData:
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 초기화 하시겠습니까?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "아니요", style: .cancel)
            let ok = UIAlertAction(title: "네", style: .default, handler: okButtonPressed)
            
            alert.addAction(cancel)
            alert.addAction(ok)
            
            present(alert, animated: true)
        }
    }
    
    func okButtonPressed(_ alert: UIAlertAction) {
        UserDefaults.standard.set(false, forKey: "isSelected")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: SelectViewController.identifier) as! SelectViewController
        let nav = UINavigationController(rootViewController: vc)
                
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
