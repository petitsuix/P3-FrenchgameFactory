//
//  Warrior.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Warrior: Character {
    // FIXME: trouver d'autres armes chestWeapons
    private let masseLegendaire = Weapon(weaponType: "masse légendaire     🔩", damages: 70)
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 120
        maxHp = 120
        healSkill = 15
        defaultCharacterDamages = 50
        chestWeapons = [masseLegendaire, masseLegendaire, masseLegendaire]
        weapon = Weapon(weaponType: "masse en fer     🔩", damages: 50)
        description = "1. Guerrier 👨🏿‍⚖️ ▸ pdv: \(maxHp) | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "guerrier 👨🏿‍⚖️"
    }
    
}
