//  Player.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Player {
    
    // MARK: - Internal properties
    
    var name: String
    
    // ⬇︎ Characters array. Contains each player's 3 characters chosen during the game initialisation phase
    var squad: [Character] = []
    
    // ⬇︎ Same as squad array, but elements are filtered so it only contains alive characters.
    var aliveSquadCharacters: [Character] {
        squad.filter { $0.hp > 0 }
    }
    
    // ⬇︎ Allows to know if all elements in a squad are dead, and therefore if the game is over
    var squadIsDead: Bool {
        if aliveSquadCharacters.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    init(name: String) {
        self.name = name
    }
    // MARK: - Private properties
    
    // ⬇︎ Allows to keep a reference to the character chosen by the player for an ongoing round. It is used in several methods throughout battleRounds phase (chest(), attack()...) therefore wasn't declared on a local level.
    private var fightingCharacter = Character(name: "")
    
    // MARK: - Internal methods
    
    // ⬇︎ Adds instances of Character subclasses to the player's squad. Up to 3, asks for a character type and a unique name.
    func createMySquad() {
        let playableCharacters = [Warrior(), Magus(), Dwarf(), Colossus(), Priest()]
        while squad.count < 3 {
            print("🔔 Choisis le personnage numero \(squad.count+1) parmi les suivants :\n")
            for character in playableCharacters {
                print("\(character.description)")
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
    
    func chooseFighterAction(enemySquad: [Character]) {
        print("🔔 Que veux-tu faire ?\n"
                + "\n1. Soigner un allié ⛑"
                + "\n2. Attaquer un membre de l'escouade adverse 🔪")
        if let choice = readLine() {
            switch choice {
            case "1" :
                healChoices()
            case "2" :
                attackChoices(enemySquad: enemySquad)
            default: print("🚣‍♀️ Merci de taper un chiffre correspondant à l'une des deux options.")
                chooseFighterAction(enemySquad: enemySquad)
            }
        }
    }
    
    // MARK: - Private methods
    
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
    
    private func choosenFighter(characterNumber: Int) {
        fightingCharacter = squad[characterNumber]
        print("\nTu as choisi de jouer avec \(fightingCharacter.name), ton \(fightingCharacter.characterType)")
        chest() // ‣ random event
    }
    
    private func chest() {
        // ⬇︎ The value of chestChances determines if a chest appears or not
        
        let chestChances = Int.random(in: 1...10)
        if chestChances <= 5, let chestWeapon = fightingCharacter.chestWeapons.randomElement() {
            fightingCharacter.drewChestWeapon = chestWeapon
            print("\nAttends voir... 🧝‍♂️✨🧝 Les elfes t'ont fait parvenir un coffre ! Voyons ce qu'il y a dedans... 🔍")
            print("\nIl contient une arme : ✨ \(fightingCharacter.drewChestWeapon.type) ✨ Cette arme inflige \(fightingCharacter.drewChestWeapon.damages) points de dégâts !")
            keepChestWeaponOrNot(drewChestWeapon: fightingCharacter.drewChestWeapon)// ‣ Asks the player if he'll keep the weapon found in the chest
        }
    }
    
    // ⬇︎ Chest weapon confirmation method
    private func keepChestWeaponOrNot(drewChestWeapon: Weapon) {
        print("\nVeux-tu t'en équiper pour ce tour ?\n\n"
                + "1. Oui 🙋\n"
                + "2. Non 🙅")
        if let choice = readLine() {
            switch choice {
            case "1" :
                // ‣ Oui: current weapon is replaced
                fightingCharacter.currentWeapon = drewChestWeapon
                print("\nTrès bien, on la prend ! 🎒\n")
            case "2" :
                print("\nTrès bien, on leur retourne le cadeau ! 💨")
                break
            default :
                print("🚣‍♂️ Merci de saisir un chiffre correspondant à Oui ou Non.")
                keepChestWeaponOrNot(drewChestWeapon: drewChestWeapon)
            }
        }
    }
    
    private func healChoices() {
        print("Quel allié veux-tu soigner ? 🏥\n")
        for (index, character) in squad.enumerated() {
            if character.hp > 0 { // ‣
                print("\(index+1). Soigner \(character.name) ton \(character.characterType) (\(character.hp)/\(character.maxHp) hp) \n")
            }
        }
        
        if let choice = readLine() {
            switch choice {
            case "1" where squad[0].hp > 0 :
                heal(characterNumber: 0)
            case "2" where squad[1].hp > 0 :
                heal(characterNumber: 1)
            case "3" where squad[2].hp > 0 :
                heal(characterNumber: 2)
            default :
                print("\n🚣‍♂️ Merci de saisir un chiffre correspondant à l'un des personnages de ton escouade.\n\n")
                healChoices()
            }
        }
    }
    
    private func heal(characterNumber: Int) {
        let target = squad[characterNumber] // ‣ target = healed character
        if target.hp <= target.maxHp - fightingCharacter.healSkill { // ‣ If the difference between the target's current and max HPs is greater than or equal to the fighting character's healSkill amount, add this amount as a whole :
            target.hp += fightingCharacter.healSkill
            print("\(target.name) récupère \(fightingCharacter.healSkill) points de vie ♥️ \(target.name) a désormais \(target.hp) hp\n")
        } else if target.hp == target.maxHp { // ‣ If target's current HPs are already at their maximum
            print("\n🚣‍♂️ Ce personnage avait déjà le maximum de points de vie. Cela n'a eu aucun effet...\n\n")
        } else { // ‣ If the difference between the target's current and max HPs is lower than the fighting character's healSkill amount, only add the difference to reach maxHP
            print("\(target.name) récupère \(target.maxHp - target.hp) points de vie ♥️")
            target.hp += target.maxHp - target.hp
            print(" \(target.name) a désormais \(target.maxHp) hp\n")
        }
    }
    
    private func attackChoices(enemySquad: [Character]) {
        print("\n\nQuel ennemi veux-tu attaquer ? ⚔️\n")
        for (index, character) in enemySquad.enumerated() {
            if character.hp > 0 {
                print("\(index+1). Attaquer \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
            }
        }
        
        if let choice = readLine() {
            switch choice {
            case "1" where enemySquad[0].hp > 0 : attack(target: enemySquad[0])
            case "2" where enemySquad[1].hp > 0 : attack(target: enemySquad[1])
            case "3" where enemySquad[2].hp > 0 : attack(target: enemySquad[2])
            default: print("🚣‍♂️ Merci de saisir un chiffre correspondant à l'action souhaitée\n")
                attackChoices(enemySquad: enemySquad)
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
