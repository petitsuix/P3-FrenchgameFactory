//
//  Warrior.swift
//  P3-game
//
//  Created by Richardier on 17/08/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Warrior: Character {
    
    override init(name: String = "") {
    super.init(name: name)
    hp = 120
    maxHp = 120
    healSkill = 15
    defaultCharacterDamages = 50
    weapon = Weapon(weaponType: "masse en fer", damages: 50)
    description = "1. Guerrier ▸ pdv: \(maxHp), arme: \(weapon.weaponType) (\(weapon.damages) de dégâts), soins: \(healSkill)"
    characterType = "guerrier"
    }
    
//    class IronSledgeHammer: Weapon {
//        init(weaponType: String, damages: Int) {
//            self.weaponType = "marteau en fer"
//            self.damages = 35
//    }
//    }
    
}



// surement à utiliser dans la fonction chest :
    
//    override init() {
//        super.init()
//        hp += 25
//        damagePoints -= 30
//    }
    
    
    
    
//    override func present() {
//        print("\(characterName) le \(characterType) a \(hp) et \(weapon.damages) points d'attaque")
//    }
