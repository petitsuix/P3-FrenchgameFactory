//
//  Character.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Character {
    
  // ⬇︎ Type du personnage : Magicien, Chevalier, Druide...
    var characterType = String()
    
  // ⬇︎ Nombre de points de vie du personnage
    var hp = 100
    
  // ⬇︎ Arme du personnage
    var weapon = Weapon()
    
  // ⬇︎ Tableau référent contenant tous les noms des personnages choisis par tous les joueurs. Appelé uniquement dans la fonction createMySquad de la classe Player lors de l'assignation par l'utilisateur de noms à ses personnages. Ce tableau permet de s'assurer que les noms choisis n'existent pas déjà.
    static var charactersNames = [String]()
    
  // ⬇︎ Un nom propre à chaque personnage
    var characterName = String()
}


