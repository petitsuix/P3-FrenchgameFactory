//
//  Character.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Character {
    
    var chestWeapons: [Weapon] = []
    
    var description = ""
    
    // ⬇︎ Character's name
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var characterType = String()
    
    // ⬇︎ Character's health points
    var hp: Int = 100
    
    // ⬇︎ Character's maximum health points
    var maxHp = 100
    
    var healSkill = Int()
    
    // ⬇︎ Weapon currently held
    var currentWeapon = Weapon(weaponType: "", damages: 0)
    
    var chestWeapon = Weapon(weaponType: "", damages: 0)
    
    var defaultWeapon = Weapon(weaponType: "", damages: 0)
    
    // ⬇︎ Array of reference for all characters names chosen by players. Only called in chooseName (in Player) when a player is assigning names to his characters. It allows to verify that the entry doesn't already exist. Was set as static because we want it common to all players, so they all interact with and fill the same array property
    static var charactersNames: [String] = []
}



