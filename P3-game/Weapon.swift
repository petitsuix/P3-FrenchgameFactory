//
//  Weapon.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Weapon {
    var weaponType: String
    var damages: Int

    init(weaponType: String, damages: Int) {
        self.damages = damages
        self.weaponType = weaponType
    }

}

//var ironSledgeHammer = Weapon(type: "marteau en fer", damages: 35)
//var treeTrunk = Weapon(type: "tronc d'arbre", damages: 40)
//var magicWand = Weapon(type: "baguette magique", damages: 45)
//var axe = Weapon(type: "hâche", damages: 27)
//var stick = Weapon(type: "bâton des sâges", damages: 17)



//let magicWand = Weapon(weaponType: "baguette magique", damages: 20)



