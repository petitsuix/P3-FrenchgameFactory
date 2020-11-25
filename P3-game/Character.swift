//
//  Character.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Character {
    
    var description = ""
    
    var name: String
    
    var characterType = String()
    
    // ⬇︎ Character's health points
    var hp: Int = 100
    
    // ⬇︎ Character's maximum health points
    var maxHp: Int = 100
    
    var healSkill = Int()
    
    var defaultWeapon = Weapon(type: "", damages: 0)
    
    // ⬇︎ Weapon currently held
    var currentWeapon = Weapon(type: "", damages: 0)
    
    var chestWeapons: [Weapon] = []
    
    // ⬇︎ Array of reference for all characters names chosen by players. Only called in chooseName (in Player) when a player is assigning names to his characters. It allows to verify that the entry doesn't already exist. Was set as static because we want it changeable by player instances, so they all interact with and fill the same array
    static var charactersNames: [String] = []
    
    init(name: String) {
        self.name = name
    }
}



