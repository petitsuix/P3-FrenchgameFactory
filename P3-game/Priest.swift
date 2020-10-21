//
//  Priest.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Priest: Character {
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 90
    maxHp = 90
    healSkill = 65
    weapon = Weapon(weaponType: "bâton des sages  🎋", damages: 20)
    defaultCharacterDamages = 20
    description = "5. Prêtre   🧖🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "prêtre 🧖🏼‍♂️"
    }
    
}
