//  Player.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Player {
    
    var name = String()
    
    // ⬇︎ Tableau de characters, correspondants aux 3 personnages de chaque joueur choisis en début de partie
    var squad: [Character] = []
    
    // ⬇︎ Tableau squad, mais avec éléments filtrés pour ne contenir que les characters encore vivants
    var aliveSquadCharacters: [Character] {
        squad.filter { $0.hp > 0 }
    }
    
    // ⬇︎ Permet de savoir si tous les membres d'un squad sont morts, et donc si la partie est terminée
    var squadIsDead: Bool {
        if aliveSquadCharacters.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // ⬇︎ Propriété permettant de garder une référence au character choisi par le joueur pour le round en cours (dans le contexte actuel, donne la possibilité de jongler avec les valeurs des armes et de leur redonner leurs valeurs par défaut au besoin)
    private var fightingCharacter = Character(name: "")
    
    // ⬇︎ La valeur de chestChances déterminera si un coffre apparaît devant le personnage, ou non.
    private var chestChances = Int()
    
    // ⬇︎ Création des escouades de 3 personnages par le joueur. Dans la limite de 3, ajout des instances Character, choix du type de personnage puis d'un nom unique par l'utilisateur.
    func createMySquad() {
        let playableCharacters = [Warrior(), Magus(), Dwarf(), Colossus(), Priest()]
        while squad.count < 3 {
            print("🔔 Choisis le personnage numero \(squad.count+1) parmi les suivants :\n")
            for characters in playableCharacters {
                print("\(characters.description)")
            }
            let choice = readLine()
            switch choice {
                /* Chaque cas permet dans l'ordre :
                 • d'ajouter un Character au tableau [squad]
                 • d'appeler la fonction chooseName dont le paramètre correspond au type (Guerrier, Mage, Nain...) respectif de chaque personnage
                 */
            case "1" :
                squad.append(Warrior())
                chooseName(of: "Guerrier 👨🏿‍⚖️")
            case "2" :
                squad.append(Magus())
                chooseName(of: "Mage 🧙🏼‍♂️")
            case "3" :
                squad.append(Dwarf())
                chooseName(of: "Nain 👨🏿‍🚒")
            case "4" :
                squad.append(Colossus())
                chooseName(of: "Colosse 🏋🏻")
            case "5" :
                squad.append(Priest())
                chooseName(of: "Prêtre 🧖🏼‍♂️")
            default: print("🚣‍♂️ Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
            }
        }
    }
    
    
    // ⬇︎ Permet à l'utilisateur de choisir un nom unique pour chacun de ses trois personnages.
    private func chooseName(of type: String) {
        print("\nTu as opté pour un \(type) choisis-lui un nom 🏷")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Si userInput est égale à readLine (trimmée), et si elle n'est pas vide :
            if Character.charactersNames.contains(userInput) { // On vérifie dans le tableau récapitulatif de tous les noms si ce dernier existe déjà
                print("Ce nom est déjà pris.")
                chooseName(of: type)
            } else {
                Character.charactersNames.append(userInput) // On ajoute la valeur au tableau récapitulatif de tous les noms
                squad[squad.count-1].name = userInput // On assigne également cette valeur à la propriété 'name' du personnage en question
                print("\nAdjugé vendu 🙌 Ton \(type) se nommera \(userInput) !\n\n")
            }
        } else {
            print("Choisis un nom valide")
            chooseName(of: type)
        }
    }
    
    // ⬇︎ Permet à l'utilisateur de choisir le personnage avec lequel il souhaite effectuer une action pour le round en cours
    func pickFighter() {
        print("🎲 Équipe \(name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre :\n")
        // ⬇︎ Affiche une liste des personnages vivants et disponibles dans l'escouade.
        for (index, character) in aliveSquadCharacters.enumerated() {
            print("\(index+1). \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
        }
        if let choice = readLine() {
            switch choice {
            case "1" :
                choosenFighter(characterNumber: 0)
            case "2" :
                choosenFighter(characterNumber: 1)
            case "3" :
                choosenFighter(characterNumber: 2)
            default:
                print("\n🚣‍♀️ Ce héros n'existe pas. Tape un chiffre correspondant puis appuie sur 'Entrée'.")
                pickFighter()
            }
        }
        
    }
    
    private func choosenFighter(characterNumber: Int) {
        if squad.indices.contains(characterNumber) { // ‣ Permet de sécuriser la saisie, dans le cas ou l'utilisateur souhaiterait appeler un personnage déjà éliminé.
            fightingCharacter = aliveSquadCharacters[characterNumber] // ‣ On mémorise quel personnage va au combat pour ce round
            print("\nTu as choisi de jouer avec \(fightingCharacter.name), ton \(fightingCharacter.characterType)")
            chest() // ‣ évènement aléatoire
        } else {
            print("\n🚣‍♀️ Choisis un personnage qui est encore vivant !")
            pickFighter()
        }
    }
    
    private func chest() {
        chestChances = Int.random(in: 1...10) // ‣ chances de voir un coffre apparaître
        if chestChances <= 5 {
            fightingCharacter.chestWeapon = fightingCharacter.chestWeapons.randomElement()!
            print("\nAttends voir... 🧝‍♂️✨🧝 Les elfes t'ont fait parvenir un coffre ! Voyons ce qu'il y a dedans... 🔍")
            print("\nIl contient une arme : ✨ \(fightingCharacter.chestWeapon.weaponType) ✨ Cette arme inflige \(fightingCharacter.chestWeapon.damages) points de dégâts !")
            keepChestWeaponOrNot(chestWeapon: fightingCharacter.chestWeapon)// ‣ Demande au joueur s'il souhaite garder l'arme trouvée
        }
    }
    
    // ⬇︎ Méthode de confirmation
    // FIXME: rentrer paramètre defaultWeapon, et donc changer Weapon avec des let car ça ne changera pas 
    private func keepChestWeaponOrNot(chestWeapon: Weapon) {
        print("\nVeux-tu t'en équiper pour ce tour ?\n\n"
            + "1. Oui 🙋\n"
            + "2. Non 🙅")
        if let choice = readLine() {
            switch choice {
            case "1" :
                // ‣ Oui: L'arme actuelle est remplacée
                fightingCharacter.weapon = chestWeapon
                print("\nTrès bien, on la prend ! 🎒\n")
            case "2" :
                fightingCharacter.weapon.damages = fightingCharacter.defaultCharacterDamages // ‣ Non: On réattribue les caractéristiques par défaut
                fightingCharacter.weapon.weaponType = fightingCharacter.defaultWeaponType
                print("\nTrès bien, on leur retourne le cadeau ! 💨")
            default :
                print("🚣‍♂️ Merci de saisir un chiffre correspondant à Oui ou Non.")
                keepChestWeaponOrNot(chestWeapon: chestWeapon)
            }
        }
    }
    
    func chooseFighterAction(characters: [Character]) {
        
        print("🔔 Que veux-tu faire ?\n"
            + "\n1. Soigner un allié ⛑"
            + "\n2. Attaquer un membre de l'escouade adverse 🔪")
        if let choice = readLine() {
            switch choice {
            case "1" :
                healAlly(characters: characters)

            case "2" :
                attackEnnemy(characters: characters)
                
            default: print("🚣‍♀️ Merci de taper un chiffre correspondant à l'une des deux options.")
            chooseFighterAction(characters: characters)
            }
        }
    }
    
    private func healAlly(characters: [Character]) { // Le paramètre est utilisé pour le case 0, dans le cas ou le joueur revient au menu précédent.
        
        print("Quel allié veux-tu soigner ? 🏥\n")
        for (index, character) in aliveSquadCharacters.enumerated() {
            print("\(index+1). Soigner \(character.name) ton \(character.characterType) (\(character.hp)/\(character.maxHp) hp) \n")
        }
        print("0. Effectuer une autre action 🙇🏻‍♂️")
        
        if let choice = readLine() {
            switch choice {
            case "1" :
                heal(characterNumber: 0)
            case "2" :
                heal(characterNumber: 1)
            case "3" :
                heal(characterNumber: 2)
            case "0" :
                chooseFighterAction(characters: characters) // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
                
            default :
                print("\n🚣‍♂️ Merci de saisir un chiffre correspondant à l'un des personnages de ton escouade, ou taper '0' puis 'Entrée' pour effectuer une autre action.\n\n")
                healAlly(characters: aliveSquadCharacters)
            }
            
        }
    }
    
    private func heal(characterNumber: Int) { // ‣ "Soigner caractère numéro: 0, 1 ou 2"
        let target = squad[characterNumber]
        if squad.indices.contains(characterNumber) {
            if target.hp <= target.maxHp - fightingCharacter.healSkill { // ‣ Si les HP actuels du character ciblé par le soin ont un écart supérieur ou égal au montant de la propriété HealSkill, comparé à son maxHP, ajouter ce montant en entier.
                target.hp += fightingCharacter.healSkill
                print("\(target.name) récupère \(fightingCharacter.healSkill) points de vie ♥️ \(target.name) a désormais \(target.hp) hp\n")
            } else if target.hp == target.maxHp { // ‣ Si les hp actuels du character sont déjà au maximum :
                print("\n🚣‍♂️ Ce personnage a déjà le maximum de points de vie. Soigne un autre membre de ton escouade ou effectue une autre action.\n\n")
                healAlly(characters: aliveSquadCharacters)
            } else { // ‣ Si les HP actuels du character ont un écart inférieur au montant de la compétence healskill, ajouter seulement la différence pour atteindre le maxHp.
                print("\(target.name) récupère \(target.maxHp - target.hp) points de vie ♥️")
                target.hp += target.maxHp - target.hp
                print(" \(target.name) a désormais \(target.maxHp) hp\n")
            }
        } else {
            print("🚣‍♂️ Bien essayé ! Séléctionne un héros vivant.")
            healAlly(characters: aliveSquadCharacters)
        }
        
    }
    
    
    
    private func attackEnnemy(characters: [Character]) {
        print("\n\nQuel ennemi veux-tu attaquer ? ⚔️\n")
        for (index, character) in characters.enumerated() {
            print("\(index+1). Attaquer \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
        }
        print("0. Effectuer une autre action 🙇🏻‍♂️")
        
        if let choice = readLine() {
            switch choice {
            case "1" : attack(character: characters[0]) // "Attaquer le character numéro: "
            case "2" : attack(character: characters[1])
            case "3" : attack(character: characters[2])
            case "0" : chooseFighterAction(characters: characters) // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
            default: print("🚣‍♂️ Merci de saisir un chiffre correspondant à l'action souhaitée\n")
            attackEnnemy(characters: characters)
            }
            
        }
    }
    

    private func attack(character: Character) {
        
        
        character.hp -= fightingCharacter.weapon.damages
        print("\nTon héros frappe \(character.name) pour \(fightingCharacter.weapon.damages) de dégâts ! 💔\n")
        if character.hp > 0 {
            print("\(character.name) a désormais \(character.hp)/\(character.maxHp) hp\n\n")
        } else {
            print("\(character.name) n'a plus aucun point de vie 💀 \(character.name) est retiré de l'escouade !\n\n\n")
            character.hp = 0
        }
        fightingCharacter.weapon.damages = fightingCharacter.defaultCharacterDamages
    }
}
