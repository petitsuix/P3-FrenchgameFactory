//
//  Magus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Magus: Character {
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 70
    maxHp = 70
    healSkill = 10
    defaultCharacterDamages = 65
    weapon = Weapon(weaponType: "baguette astrale 🦯", damages: 65)
    description = "2. Mage     🧙🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "mage 🧙🏼‍♂️"
    }
    
}
