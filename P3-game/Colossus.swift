//
//  Colossus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Colossus: Character {
    
    private let brick = Weapon(weaponType: "brique", damages: 12)
    private let tableStand = Weapon(weaponType: "pied de table", damages: 24)
    private let crossBow = Weapon(weaponType: "arbalète", damages: 60)
    private let ironScythe = Weapon(weaponType: "faux en acier", damages: 70)
    private let spearOfTheDoomed = Weapon(weaponType: "lance des Damnés", damages: 80)
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 140
    maxHp = 140
    healSkill = 15
    weapon = Weapon(weaponType: "tronc d'arbre    🌲", damages: 40)
    chestWeapons = [brick, tableStand, crossBow, ironScythe, spearOfTheDoomed]
    defaultCharacterDamages = 40
    description = "4. Colosse  🏋🏻 ▸ pdv: \(maxHp) | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "colosse 🏋🏻"
    }
    
}
