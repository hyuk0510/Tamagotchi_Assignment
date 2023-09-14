//
//  RiceWaterButton.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/21.
//

import UIKit

@IBDesignable
class RiceButton: UIButton {
    
    @IBInspectable
    var riceButton: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
