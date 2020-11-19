//
//  Magus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Magus: Character {
    
    private let breadWand = Weapon(type: "baguette de pain", damages: Int.random(in: 4...22))
    private let leprechaunsStick = Weapon(type: "bâton du lutin irlandais", damages: Int.random(in: 23...44))
    private let demonicSword = Weapon(type: "épée démonique", damages: Int.random(in: 44...69))
    private let sorcerersMysticalStone = Weapon(type: "pierre mystique des Sorciers", damages: Int.random(in: 70...78))
    private let archangelsStick = Weapon(type: "bâton des Archanges", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 70
        maxHp = 70
        healSkill = 10
        defaultWeapon = Weapon(type: "baguette astrale 🦯", damages: 65)
        currentWeapon = Weapon(type: "baguette astrale 🦯", damages: 65)
        chestWeapons = [breadWand, leprechaunsStick, demonicSword, sorcerersMysticalStone, archangelsStick]
        description = "2. Mage     🧙🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(currentWeapon.type) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "mage 🧙🏼‍♂️"
    }
}
