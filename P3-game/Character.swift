//
//  Character.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Character {
    
  // ⬇︎ Type du personnage : Magicien, Chevalier, Druide...
    var characterType = String()
    
  // ⬇︎ Nombre de points de vie du personnage
    var hp: Int = 100
    
  // ⬇︎ Nombre de points de vie maximum du personnage
    var maxHp = 100
    
  // ⬇︎ Arme du personnage
    var weapon = Weapon()
    
  // ⬇︎ Dégats infligés par le personnage
    var damagePoints = Int()
    
  // ⬇︎ Addition de tous les dégats infligés par le personnage
    var totalDamages = 0
  // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction createMySquad de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà.
    static var charactersNames = [String]()
    
  // ⬇︎ Un nom propre à chaque personnage
    var characterName = String()
    
  // ⬇︎ Permet de présenter les charactéristiques des personnages
    func present() {
        print("\(characterName) a \(hp) et \(weapon.damage) points d'attaque")
    }
    
  /*  func strongestCharacter(character: Character) -> String {
        if character.damagePoints >
        return "Le personnage le plus fort est \(character)"
    }
 */
}

    
