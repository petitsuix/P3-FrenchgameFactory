//
//  Warrior.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Warrior: Character {
    
    private let sandal = Weapon(type: "sandale", damages: Int.random(in: 4...22))
    private let woodenClub = Weapon(type: "gourdin en bois", damages: Int.random(in: 23...44))
    private let steelMace = Weapon(type: "masse en acier", damages: Int.random(in: 44...69))
    private let legendaryMace = Weapon(type: "masse légendaire", damages: Int.random(in: 70...78))
    private let oraclesFireAxe = Weapon(type: "hâche de feu des Oracles", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 120
        maxHp = 120
        healSkill = 15
        chestWeapons = [legendaryMace, sandal, woodenClub, steelMace, oraclesFireAxe]
        defaultWeapon = Weapon(type: "masse en fer     🔩", damages: 50)
        currentWeapon = Weapon(type: "masse en fer     🔩", damages: 50)
        description = "1. Guerrier 👨🏿‍⚖️ ▸ pdv: \(maxHp) | arme: \(currentWeapon.type) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "guerrier 👨🏿‍⚖️"
    }
}
