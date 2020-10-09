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
    
    // ⬇︎ Un nom propre à chaque personnage
    var characterName = String()
    
    // ⬇︎ Type du personnage : Magicien, Guerrier, Nain...
    var characterType = String()
    
  // ⬇︎ Nombre de points de vie du personnage
    var hp: Int = 100
    
  // ⬇︎ Nombre de points de vie maximum du personnage
    var maxHp = 100
    
    var healSkill = Int()
    
    // ⬇︎ Détermine qui fait l'action :
    var fightingCharacterNumber = Int()
    
//  // ⬇︎ Arme du personnage
    var weapon = Weapon(weaponType: "", damages: 0)
    
    var defaultCharacterDamages = Int()
  // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction createMySquad de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà.
    static var charactersNames = [String]()
    
    let name: String
  
    init(name: String) {
        self.name = name
    }
//  // ⬇︎ Permet de présenter les charactéristiques des personnages
//    func present() {
//        print("\(characterName) a \(hp) et son arme cause \(damagePoints) de dégâts")
//    }
//    
  /*  func strongestCharacter(character: Character) -> String {
        if character.damagePoints >
        return "Le personnage le plus fort est \(character)"
    }
 */
    
    
    
}



