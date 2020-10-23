//
//  Priest.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Priest: Character {
    
    private let mandoline = Weapon(weaponType: "mandoline", damages: 12)
    private let sickle = Weapon(weaponType: "faucille", damages: 24)
    private let natureStick = Weapon(weaponType: "bâton de la nature", damages: 60)
    private let stormStick = Weapon(weaponType: "bâton des tempêtes", damages: 70)
    private let godsSceptre = Weapon(weaponType: "sceptre des Dieux", damages: 80)
     
    override init(name: String = "") {
    super.init(name: name)
    hp = 90
    maxHp = 90
    healSkill = 65
    weapon = Weapon(weaponType: "bâton des sages  🎋", damages: 20)
    chestWeapons = [mandoline, sickle, natureStick, stormStick, godsSceptre]
    defaultCharacterDamages = 20
    description = "5. Prêtre   🧖🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "prêtre 🧖🏼‍♂️"
    }
    
}
