//
//  Tamagotchi.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import Foundation

struct Tamagotchi: Codable {
    var name: String
    var rice: Int
    var water: Int
    var level: Int {
        let level = Int((rice / 5 + water / 2) / 10)
        if level == 0 {
            return 1
        } else if level > 10 {
            return 10
        } else {
            return level
        }
    }
    var introduce: String
}
