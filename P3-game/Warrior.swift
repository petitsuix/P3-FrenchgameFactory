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
    private let sandal = Weapon(weaponType: "sandale", damages: 12)
    private let woodenClub = Weapon(weaponType: "gourdin en bois", damages: 24)
    private let steelMace = Weapon(weaponType: "masse en acier", damages: 60)
    private let legendaryMace = Weapon(weaponType: "masse légendaire", damages: 70)
    private let oraclesFireAxe = Weapon(weaponType: "hâche de feu des Oracles", damages: 80)
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 120
        maxHp = 120
        healSkill = 15
        defaultWeaponType = "masse en fer     🔩"
        defaultCharacterDamages = 50
        chestWeapons = [legendaryMace, sandal, woodenClub, steelMace, oraclesFireAxe]
        weapon = Weapon(weaponType: "masse en fer     🔩", damages: 50)
        description = "1. Guerrier 👨🏿‍⚖️ ▸ pdv: \(maxHp) | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "guerrier 👨🏿‍⚖️"
    }
    
}
