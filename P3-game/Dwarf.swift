//
//  Dwarf.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Dwarf: Character {
    
    private let stool = Weapon(weaponType: "tabouret", damages: Int.random(in: 4...22))
    private let lumberJacksAxe = Weapon(weaponType: "hâche de bûcheron", damages: Int.random(in: 23...44))
    private let doubleSteelAxe = Weapon(weaponType: "hâche d'acier double", damages: Int.random(in: 45...69))
    private let doubleScourge = Weapon(weaponType: "fléau d'armes double", damages: Int.random(in: 70...78))
    private let dwarfKingsSpear = Weapon(weaponType: "épée du Roi Nain", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 100
        maxHp = 100
        healSkill = 30
        defaultWeapon = Weapon(weaponType: "hâche rutilante  🪓", damages: 40)
        currentWeapon = Weapon(weaponType: "hâche rutilante  🪓", damages: 40)
        chestWeapons = [stool, lumberJacksAxe, doubleSteelAxe, doubleScourge, dwarfKingsSpear]
        description = "3. Nain     👨🏿‍🚒 ▸ pdv: \(maxHp) | arme: \(currentWeapon.weaponType) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "nain 👨🏿‍🚒"
    }
    
}
