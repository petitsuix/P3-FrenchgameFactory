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
    
    // ⬇︎ Constante non déclarée pour assigner un nom à chaque character
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    // ⬇︎ Type du personnage : Magicien, Guerrier, Nain...
    var characterType = String()
    
    // ⬇︎ Nombre de points de vie du personnage
    var hp: Int = 100
    
    // ⬇︎ Nombre de points de vie maximum du personnage
    var maxHp = 100
    
    // ⬇︎ Compétence soin
    var healSkill = Int()
    
    // ⬇︎ Arme en main
    var currentWeapon = Weapon(weaponType: "", damages: 0)
    
    // ⬇︎ Arme du coffre
    var chestWeapon = Weapon(weaponType: "", damages: 0)
    
    // ⬇︎ Arme par défaut
    var defaultWeapon = Weapon(weaponType: "", damages: 0)
    
    // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction chooseName de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà. Il a été mis en static pour qu'il puisse être appelé et complété par chaque player
    static var charactersNames: [String] = []
}



