//
//  Extension+UIViewController.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/24.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentOverFullScreenNavigation
        case push
    }

    func transition<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: String(describing: viewController)) as? T else {
            return
        }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentOverFullScreenNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
