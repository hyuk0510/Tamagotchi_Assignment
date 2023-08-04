//
//  SelectViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import UIKit

class SelectViewController: UIViewController {
    
    @IBOutlet var tamagotchiSelectCollectionView: UICollectionView!
    
    static let identifier = "SelectViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tamagotchiSelectCollectionView.delegate = self
        tamagotchiSelectCollectionView.dataSource = self
        
        let cvNib = UINib(nibName: TamagotchiSelectCollectionViewCell.identifier, bundle: nil)
        tamagotchiSelectCollectionView.register(cvNib, forCellWithReuseIdentifier: TamagotchiSelectCollectionViewCell.identifier)
        
        designBackgroundColor()
        configureTamagotchiCollectionViewLayout()
        
        title = "다마고치 선택하기"
    }
    
    func designBackgroundColor() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        tamagotchiSelectCollectionView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }
}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TamagotchiInfo().tamagotchi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiSelectCollectionViewCell.identifier, for: indexPath) as! TamagotchiSelectCollectionViewCell
        let row = indexPath.row
        
        cell.tamagotchiSelectImageView.tag = row
        cell.configureTamagotchiSelectCollectionViewCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: TamagotchiDetailViewController.identifier) as! TamagotchiDetailViewController
        
        let row = indexPath.row
        
        vc.getData(data: TamagotchiInfo().tamagotchi[row])
    }
    
    func configureTamagotchiCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: 150)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        tamagotchiSelectCollectionView.collectionViewLayout = layout
    }
}
