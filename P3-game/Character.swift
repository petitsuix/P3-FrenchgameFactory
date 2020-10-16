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
    
    // ⬇︎ Détermine le character séléctionné (qui effectue l'action)
    var fightingCharacterNumber = Int()
    
    // ⬇︎ Arme du personnage
    var weapon = Weapon(weaponType: "", damages: 0)
    
    // ⬇︎ Dommages par défaut du character
    var defaultCharacterDamages = Int()
    
    // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction createMySquad de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà.
    static var charactersNames = [String]()
    
    
    
    
}



