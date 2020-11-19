//
//  Priest.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Priest: Character {
    
    private let mandoline = Weapon(type: "mandoline", damages: Int.random(in: 4...22))
    private let sickle = Weapon(type: "faucille", damages: Int.random(in: 23...44))
    private let natureStick = Weapon(type: "bâton de la nature", damages: Int.random(in: 45...69))
    private let stormStick = Weapon(type: "bâton des tempêtes", damages: Int.random(in: 70...78))
    private let godsSceptre = Weapon(type: "sceptre des Dieux", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 90
        maxHp = 90
        healSkill = 65
        defaultWeapon = Weapon(type: "bâton des sages  🎋", damages: 20)
        currentWeapon = Weapon(type: "bâton des sages  🎋", damages: 20)
        chestWeapons = [mandoline, sickle, natureStick, stormStick, godsSceptre]
        description = "5. Prêtre   🧖🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(currentWeapon.type) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "prêtre 🧖🏼‍♂️"
    }
}
