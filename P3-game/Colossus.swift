//
//  Colossus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Colossus: Character {
    
    private let brick = Weapon(type: "brique", damages: Int.random(in: 4...22))
    private let tableStand = Weapon(type: "pied de table", damages: Int.random(in: 23...44))
    private let crossBow = Weapon(type: "arbalète", damages: Int.random(in: 45...70))
    private let ironScythe = Weapon(type: "faux en acier", damages: Int.random(in: 71...78))
    private let spearOfTheDoomed = Weapon(type: "lance des Damnés", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 140
        maxHp = 140
        healSkill = 15
        defaultWeapon = Weapon(type: "tronc d'arbre    🌲", damages: 40)
        currentWeapon = Weapon(type: "tronc d'arbre    🌲", damages: 40)
        chestWeapons = [brick, tableStand, crossBow, ironScythe, spearOfTheDoomed]
        description = "4. Colosse  🏋🏻 ▸ pdv: \(maxHp) | arme: \(currentWeapon.type) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "colosse 🏋🏻"
    }
}
