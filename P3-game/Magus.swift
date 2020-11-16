//
//  Magus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Magus: Character {
    
    private let breadWand = Weapon(weaponType: "baguette de pain", damages: Int.random(in: 4...22))
    private let leprechaunsStick = Weapon(weaponType: "bâton du lutin irlandais", damages: Int.random(in: 23...44))
    private let demonicSword = Weapon(weaponType: "épée démonique", damages: Int.random(in: 44...69))
    private let sorcerersMysticalStone = Weapon(weaponType: "pierre mystique des Sorciers", damages: Int.random(in: 70...78))
    private let archangelsStick = Weapon(weaponType: "bâton des Archanges", damages: Int.random(in: 79...85))
    
    override init(name: String = "") {
        super.init(name: name)
        hp = 70
        maxHp = 70
        healSkill = 10
        defaultWeapon = Weapon(weaponType: "baguette astrale 🦯", damages: 65)
        currentWeapon = Weapon(weaponType: "baguette astrale 🦯", damages: 65)
        chestWeapons = [breadWand, leprechaunsStick, demonicSword, sorcerersMysticalStone, archangelsStick]
        description = "2. Mage     🧙🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(currentWeapon.weaponType) (\(currentWeapon.damages) de dégâts) | soins: \(healSkill)"
        characterType = "mage 🧙🏼‍♂️"
    }
    
}
