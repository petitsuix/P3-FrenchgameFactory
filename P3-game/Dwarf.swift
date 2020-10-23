//
//  Dwarf.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Dwarf: Character {
    
    private let stool = Weapon(weaponType: "tabouret", damages: 12)
    private let lumberJacksAxe = Weapon(weaponType: "hâche de bûcheron", damages: 24)
    private let doubleSteelAxe = Weapon(weaponType: "hâche d'acier double", damages: 60)
    private let doubleScourge = Weapon(weaponType: "fléau d'armes double", damages: 70)
    private let dwarfKingsSpear = Weapon(weaponType: "épée du Roi Nain", damages: 80)
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 100
    maxHp = 100
    healSkill = 30
    weapon = Weapon(weaponType: "hâche rutilante  🪓", damages: 40)
    chestWeapons = [stool, lumberJacksAxe, doubleSteelAxe, doubleScourge, dwarfKingsSpear]
    defaultCharacterDamages = 40
    description = "3. Nain     👨🏿‍🚒 ▸ pdv: \(maxHp) | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "nain 👨🏿‍🚒"
    }
    
}
