//
//  Colossus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Colossus: Character {
    
    private let brick = Weapon(weaponType: "brique", damages: Int.random(in: 4...22))
    private let tableStand = Weapon(weaponType: "pied de table", damages: Int.random(in: 23...44))
    private let crossBow = Weapon(weaponType: "arbalète", damages: Int.random(in: 45...70))
    private let ironScythe = Weapon(weaponType: "faux en acier", damages: Int.random(in: 71...78))
    private let spearOfTheDoomed = Weapon(weaponType: "lance des Damnés", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 140
        maxHp = 140
        healSkill = 15
        defaultWeapon = Weapon(weaponType: "tronc d'arbre    🌲", damages: 40)
        currentWeapon = Weapon(weaponType: "tronc d'arbre    🌲", damages: 40)
        chestWeapons = [brick, tableStand, crossBow, ironScythe, spearOfTheDoomed]
        description = "4. Colosse  🏋🏻 ▸ pdv: \(maxHp) | arme: \(currentWeapon.weaponType) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "colosse 🏋🏻"
    }
    
}
