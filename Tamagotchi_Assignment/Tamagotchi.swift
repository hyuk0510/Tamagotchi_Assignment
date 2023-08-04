//
//  Tamagotchi.swift
//  Tamagotchi_Assignment
//
//  Created by 선상혁 on 2023/08/04.
//

import Foundation

struct Tamagotchi {
    var name: String
    var rice: Int
    var water: Int
    var level: Int {
        return Int((rice / 5 + water / 2) / 10)
    }
    var introduce: String
}
