//  Player.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Player {
    
    var name = String()
    
    // ⬇︎ Characters array. Contains each player's 3 characters chosen during the game initialisation phase
    var squad: [Character] = []
    
    // ⬇︎ Same as squad array, but elements are filtered so it only contains alive characters.
    var aliveSquadCharacters: [Character] {
        squad.filter { $0.hp > 0 }
    }
    
    var ennemy = Player()
    
    
    // ⬇︎ Allows to know if all elements in a squad are dead, and therefore if the game is over
    var squadIsDead: Bool {
        if aliveSquadCharacters.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // ⬇︎ Allows to keep a reference to the character chosen by the player for an ongoing round. It is used in several methods throughout battleRounds phase (chest(), attack()...) therefore wasn't declared on a local level.
    private var fightingCharacter = Character(name: "")
    
    // ⬇︎ The value of chestChances determines if a chest appears or not
    private var chestChances = Int()
    
    // ⬇︎ Adds instances of Character subclasses to the player's squad. 3 times in a row, asks for a character type and a unique name.
    func createMySquad() {
        let playableCharacters = [Warrior(), Magus(), Dwarf(), Colossus(), Priest()]
        while squad.count < 3 {
            print("🔔 Choisis le personnage numero \(squad.count+1) parmi les suivants :\n")
            for characters in playableCharacters {
                print("\(characters.description)")
            }
            let choice = readLine()
            switch choice {
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
    
    
    // ⬇︎ Defines a unique name
    private func chooseName(of type: String) {
        print("\nTu as opté pour un \(type) choisis-lui un nom 🏷")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Unwrap if conditions are met
            if Character.charactersNames.contains(userInput) { // To make sure that the name doesn't already exist, checks the array containing all names
                print("Ce nom est déjà pris.")
                chooseName(of: type)
            } else {
                Character.charactersNames.append(userInput) // If not, adds the value to names array
                squad[squad.count-1].name = userInput // Also assigns the value to character's 'name' property
                print("\nAdjugé vendu 🙌 Ton \(type) se nommera \(userInput) !\n\n")
            }
        } else {
            print("Choisis un nom valide")
            chooseName(of: type)
        }
    }
    
    // ⬇︎ Allows user to pick the character he wants to play with (for the ongoing round)
    func pickFighter() {
        print("🎲 Équipe \(name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre :\n")
        // ⬇︎ Displays the list of all alive and available characters in squad
        for (index, character) in squad.enumerated() {
            if character.hp > 0 {
                print("\(index+1). \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" where squad[0].hp > 0 :
                choosenFighter(characterNumber: 0)
            case "2" where squad[1].hp > 0 :
                choosenFighter(characterNumber: 1)
            case "3" where squad[2].hp > 0 :
                choosenFighter(characterNumber: 2)
            default:
                print("\n🚣‍♀️ Tape un chiffre correspondant puis appuie sur 'Entrée'.\n\n")
                pickFighter()
            }
        }
        
    }
    
    private func choosenFighter(characterNumber: Int) {
        fightingCharacter = squad[characterNumber]
        print("\nTu as choisi de jouer avec \(fightingCharacter.name), ton \(fightingCharacter.characterType)")
        chest() // ‣ random event
    }
    
    private func chest() {
        chestChances = Int.random(in: 1...10)
        if chestChances <= 5 {
            fightingCharacter.chestWeapon = fightingCharacter.chestWeapons.randomElement()!
            print("\nAttends voir... 🧝‍♂️✨🧝 Les elfes t'ont fait parvenir un coffre ! Voyons ce qu'il y a dedans... 🔍")
            print("\nIl contient une arme : ✨ \(fightingCharacter.chestWeapon.weaponType) ✨ Cette arme inflige \(fightingCharacter.chestWeapon.damages) points de dégâts !")
            keepChestWeaponOrNot(chestWeapon: fightingCharacter.chestWeapon)// ‣ Asks the player if he'll keep the weapon found in the chest
        }
    }
    
    // ⬇︎ Chest weapon confirmation method
    private func keepChestWeaponOrNot(chestWeapon: Weapon) {
        print("\nVeux-tu t'en équiper pour ce tour ?\n\n"
                + "1. Oui 🙋\n"
                + "2. Non 🙅")
        if let choice = readLine() {
            switch choice {
            case "1" :
                // ‣ Oui: current weapon is replaced
                fightingCharacter.currentWeapon = chestWeapon
                print("\nTrès bien, on la prend ! 🎒\n")
            case "2" :
                print("\nTrès bien, on leur retourne le cadeau ! 💨")
                break
            default :
                print("🚣‍♂️ Merci de saisir un chiffre correspondant à Oui ou Non.")
                keepChestWeaponOrNot(chestWeapon: chestWeapon)
            }
        }
    }
    
    func chooseFighterAction() {
        print("🔔 Que veux-tu faire ?\n"
                + "\n1. Soigner un allié ⛑"
                + "\n2. Attaquer un membre de l'escouade adverse 🔪")
        if let choice = readLine() {
            switch choice {
            case "1" :
                healAlly()
                
            case "2" :
                attackEnnemy(ennemies: ennemy.squad)
                
            default: print("🚣‍♀️ Merci de taper un chiffre correspondant à l'une des deux options.")
                chooseFighterAction()
            }
        }
    }
    
    private func healAlly() { // Les paramètres est utilisé pour le case 0, dans le cas ou le joueur revient au menu précédent.
        print("Quel allié veux-tu soigner ? 🏥\n")
        for (index, character) in squad.enumerated() {
            if character.hp > 0 {
                print("\(index+1). Soigner \(character.name) ton \(character.characterType) (\(character.hp)/\(character.maxHp) hp) \n")
            }
        }
        print("0. Effectuer une autre action 🙇🏻‍♂️")
        
        if let choice = readLine() {
            switch choice {
            case "1" where squad[0].hp > 0 :
                heal(characterNumber: 0)
            case "2" where squad[1].hp > 0 :
                heal(characterNumber: 1)
            case "3" where squad[2].hp > 0 :
                heal(characterNumber: 2)
            case "0" :
                chooseFighterAction() // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
            
            default :
                print("\n🚣‍♂️ Merci de saisir un chiffre correspondant à l'un des personnages de ton escouade, ou taper '0' puis 'Entrée' pour effectuer une autre action.\n\n")
                healAlly()
            }
            
        }
    }
    
    private func heal(characterNumber: Int) {
        let target = squad[characterNumber]
            if target.hp <= target.maxHp - fightingCharacter.healSkill { // ‣ Si les HP actuels du character ciblé par le soin ont un écart supérieur ou égal au montant de la propriété HealSkill, comparé à son maxHP, ajouter ce montant en entier.
                target.hp += fightingCharacter.healSkill
                print("\(target.name) récupère \(fightingCharacter.healSkill) points de vie ♥️ \(target.name) a désormais \(target.hp) hp\n")
            } else if target.hp == target.maxHp { // ‣ Si les hp actuels du character sont déjà au maximum :
                print("\n🚣‍♂️ Ce personnage a déjà le maximum de points de vie. Soigne un autre membre de ton escouade ou effectue une autre action.\n\n")
                healAlly()
            } else { // ‣ Si les HP actuels du character ont un écart inférieur au montant de la compétence healskill, ajouter seulement la différence pour atteindre le maxHp.
                print("\(target.name) récupère \(target.maxHp - target.hp) points de vie ♥️")
                target.hp += target.maxHp - target.hp
                print(" \(target.name) a désormais \(target.maxHp) hp\n")
            }
    }
    
    
    private func attackEnnemy(ennemies: [Character]) {
        print("\n\nQuel ennemi veux-tu attaquer ? ⚔️\n")
        for (index, character) in ennemies.enumerated() {
            if character.hp > 0 {
                print("\(index+1). Attaquer \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
            }
        }
        print("0. Effectuer une autre action 🙇🏻‍♂️")
        
        if let choice = readLine() {
            switch choice {
            case "1" where ennemies[0].hp > 0 : attack(target: ennemies[0]) // "Attaquer le character numéro: "
            case "2" where ennemies[1].hp > 0 : attack(target: ennemies[1])
            case "3" where ennemies[2].hp > 0 : attack(target: ennemies[2])
            case "0" : chooseFighterAction() // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
            default: print("🚣‍♂️ Merci de saisir un chiffre correspondant à l'action souhaitée\n")
                attackEnnemy(ennemies: ennemies)
            }
            
        }
    }
    
    
    private func attack(target: Character) {
        target.hp -= fightingCharacter.currentWeapon.damages
        print("\nTon héros frappe \(target.name) pour \(fightingCharacter.currentWeapon.damages) de dégâts ! 💔\n")
        if target.hp > 0 {
            print("\(target.name) a désormais \(target.hp)/\(target.maxHp) hp\n\n")
        } else {
            print("\(target.name) n'a plus aucun point de vie 💀 \(target.name) est retiré de l'escouade !\n\n\n")
            target.hp = 0
        }
        fightingCharacter.currentWeapon = fightingCharacter.defaultWeapon
    }
}
