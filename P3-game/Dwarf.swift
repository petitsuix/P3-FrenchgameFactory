//
//  Dwarf.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Dwarf: Character {
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 100
    maxHp = 100
    healSkill = 30
    weapon = Weapon(weaponType: "hâche", damages: 40)
    defaultCharacterDamages = 40
    description = "3. Nain ▸ pdv: \(maxHp), arme: \(weapon.weaponType) (\(weapon.damages) de dégâts), soins: \(healSkill)"
    characterType = "nain"
    }
    
}
