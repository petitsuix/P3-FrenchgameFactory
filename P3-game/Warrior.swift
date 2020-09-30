//
//  Warrior.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Warrior: Character {
    
    override init() {
        super.init()
        hp += 25
        damagePoints -= 30
    }
    override func present() {
        print("\(characterName) le \(characterType) a \(hp) et \(weapon.damage) points d'attaque")
    }
    
}
