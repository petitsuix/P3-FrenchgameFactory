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
    
    // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction chooseName de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà. Il a été mis en static pour qu'il puisse être appelé et complété par chaque player
    // ⬇︎ Array of reference for all characters names chosen by players. Only called in
    static var charactersNames: [String] = []
}



