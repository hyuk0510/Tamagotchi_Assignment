//
//  ReusableViewProtocol.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/16.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell : ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
