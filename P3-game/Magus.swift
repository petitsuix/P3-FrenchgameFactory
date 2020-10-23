//
//  Magus.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Magus: Character {
    
    private let breadWand = Weapon(weaponType: "baguette de pain", damages: 12)
    private let leprechaunsStick = Weapon(weaponType: "bâton du lutin irlandais", damages: 24)
    private let demonicSword = Weapon(weaponType: "épée démonique", damages: 60)
    private let sorcerersMysticalStone = Weapon(weaponType: "pierre mystique des Sorciers", damages: 70)
    private let archangelsStick = Weapon(weaponType: "bâton des Archanges", damages: 80)
    override init(name: String = "") {
    super.init(name: name)
    hp = 70
    maxHp = 70
    healSkill = 10
    defaultCharacterDamages = 65
    weapon = Weapon(weaponType: "baguette astrale 🦯", damages: 65)
    chestWeapons = [breadWand, leprechaunsStick, demonicSword, sorcerersMysticalStone, archangelsStick]
    description = "2. Mage     🧙🏼‍♂️ ▸ pdv: \(maxHp)  | arme: \(weapon.weaponType) (\(weapon.damages) de dégâts) | soins: \(healSkill)"
    characterType = "mage 🧙🏼‍♂️"
    }
    
}
