//
//  Priest.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Priest: Character {
    
    private let mandoline = Weapon(weaponType: "mandoline", damages: Int.random(in: 4...22))
    private let sickle = Weapon(weaponType: "faucille", damages: Int.random(in: 23...44))
    private let natureStick = Weapon(weaponType: "bâton de la nature", damages: Int.random(in: 45...69))
    private let stormStick = Weapon(weaponType: "bâton des tempêtes", damages: Int.random(in: 70...78))
    private let godsSceptre = Weapon(weaponType: "sceptre des Dieux", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 90
        maxHp = 90
        healSkill = 65
        defaultWeapon = Weapon(weaponType: "bâton des sages  🎋", damages: 20)
        currentWeapon = Weapon(weaponType: "bâton des sages  🎋", damages: 20)
        chestWeapons = [mandoline, sickle, natureStick, stormStick, godsSceptre]
        description = "5. Prêtre   🧖🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(currentWeapon.weaponType) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "prêtre 🧖🏼‍♂️"
    }
    
}
