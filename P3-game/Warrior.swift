//
//  Warrior.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Warrior: Character {
    private let sandal = Weapon(weaponType: "sandale", damages: Int.random(in: 4...22))
    private let woodenClub = Weapon(weaponType: "gourdin en bois", damages: Int.random(in: 23...44))
    private let steelMace = Weapon(weaponType: "masse en acier", damages: Int.random(in: 44...69))
    private let legendaryMace = Weapon(weaponType: "masse légendaire", damages: Int.random(in: 70...78))
    private let oraclesFireAxe = Weapon(weaponType: "hâche de feu des Oracles", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 120
        maxHp = 120
        healSkill = 15
        chestWeapons = [legendaryMace, sandal, woodenClub, steelMace, oraclesFireAxe]
        defaultWeapon = Weapon(weaponType: "masse en fer     🔩", damages: 50)
        currentWeapon = Weapon(weaponType: "masse en fer     🔩", damages: 50)
        description = "1. Guerrier 👨🏿‍⚖️ ▸ pdv: \(maxHp) | arme: \(currentWeapon.weaponType) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "guerrier 👨🏿‍⚖️"
    }
    
}
