//
//  Colossus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Colossus: Character {
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 140
    maxHp = 140
    healSkill = 15
    weapon = Weapon(weaponType: "tronc d'arbre    🌲", damages: 40)
    defaultCharacterDamages = 40
    description = "4. Colosse  🏋🏻 ▸ pdv: \(maxHp) | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "colosse 🏋🏻"
    }
    
}
