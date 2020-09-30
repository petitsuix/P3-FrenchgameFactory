//  Player.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Player {
    
    /* private */ var name = String()
    
    // ⬇︎ Tableau contenant les instances de la classe Character, correspondants aux 3 personnages de chaque joueur
    var squad: [Character] = []
    
    var deadSquadMembers: [Character] = []
    
    var didIWin: String?
    
    
    // ⬇︎ Permet au programme d'aller chercher et d'attaquer l'escouade adverse en changeant l'index du tableau de Players. Elle est statique pour pouvoir l'utiliser dans la classe Game, dans la fonction "startRound": on lui ajoute 1 à chaque tour de boucle "for player in [players]" et lorsque la boucle est terminée (signifiant la fin du round 1) et que les deux joueurs ont chacun effectué leur action, indexCountHelper est remis à 0 pour être réutilisé au round suivant.
    static var indexCountHelper = 0
    
    // ⬇︎ Création des escouades de 3 personnages par le joueur. Dans la limite de 3, ajout des instances Character, choix du type de personnage puis d'un nom unique par l'utilisateur.
    func createMySquad() {
        while squad.count < 3 {
            let character = Character()
            print("Choisis le personnage numero \(squad.count+1) parmi les suivants :"
                + "\n1. Guerrier"
                + "\n2. Mage"
                + "\n3. Nain"
                + "\n4. Colosse"
                + "\n5. Prêtre")
            let userInput = readLine()
            let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespaces)
            if let choice = trimmedUserInput {
                switch choice {
                    /* Chaque cas permet, dans l'ordre :
                     • d'ajouter une instance de Character au tableau [squad]
                     • d'appeler la fonction chooseNameOfCharacter dont le paramètre correspond au type (druide, magicien, dragon...) respectif de chaque personnage
                     • d'assigner une valeur à la variable "characterType" correspondant au type (druide, magicien, dragon...) de personnage choisi
                     */
                case "1" :
                    squad.append(character)
                    chooseName(of: "Guerrier")
                    character.characterType = "Guerrier"
                case "2" :
                    squad.append(character)
                    chooseName(of: "Mage")
                    character.characterType = "Mage"
                case "3" :
                    squad.append(character)
                    chooseName(of: "Nain")
                    character.characterType = "Nain"
                case "4" :
                    squad.append(character)
                    chooseName(of: "Colosse")
                    character.characterType = "Colosse"
                case "5" :
                    squad.append(character)
                    chooseName(of: "Prêtre")
                    character.characterType = "Prêtre"
                default: print("Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
                }
            }
        }
    }
    
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir le nom de chacun de ses trois personnages.
    func chooseName(of type: String) {
        print("\nTu as opté pour un \(type), choisis-lui un nom :")
        let userInput = readLine()
        if Character.charactersNames.contains(userInput!) {
            print("Ce nom est déjà pris.")
            chooseName(of: type)
        }
            /* else if squad.contains(charactersName!) {
             print("Ce nom est déjà pris.")
             chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
             } */
            
        else { // FIXME: faire en sorte que ça déballe de manière safe + trimming
            Character.charactersNames.append(userInput!) // On ajoute le nom au tableau récapitulatif de tous les noms
            squad[squad.count-1].characterName = userInput!
            print("Adjugé vendu ! Ton \(type) se nommera \(userInput!) !\n")
        }
    }
    
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir le personnage avec lequel il souhaite combattre pour le round en cours
    func pickFighters() {
        print("Équipe \(name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre pendant le round \(Game.roundCount+1) :\n")
        for (index, character) in squad.enumerated() {
            print("\(index+1). \(character.characterName) le \(character.characterType)\n")
        }
        if let choice = readLine() {
            switch choice {
            case "1" :
                if squad.indices.contains(0) {
                    print("\nTu as choisi de jouer avec \(squad[0].characterName), ton \(squad[0].characterType).")
                } else {
                    print("\nChoisis un personnage qui est encore vivant !")
                    pickFighters()
                }
            case "2" :
                if squad.indices.contains(1) {
                    print("\nTu as choisi de jouer avec \(squad[1].characterName), ton \(squad[1].characterType).")
                } else {
                    print("\nChoisis un personnage qui est encore vivant !")
                    pickFighters()
                }
            case "3" :
                if squad.indices.contains(2) {
                    print("\nTu as choisi de jouer avec \(squad[2].characterName), ton \(squad[2].characterType).")
                } else {
                    print("\nChoisis un personnage qui est encore vivant !")
                    pickFighters()
                }
            default:
                print("\nCe héros n'existe pas. Tape un chiffre correspondant puis appuie sur 'Entrée'.")
                pickFighters()
            }
        }
        
    }
    
    func chooseCharacterAction() {
        
        print("Que veux-tu faire ?\n"
            + "\n1. Soigner un allié"
            + "\n2. Attaquer un membre de l'escouade adverse")
        if let choice = readLine() {
            switch choice {
            case "1" :
                healAlly()
            //  let test = players[indexCountHelper]
            case "2" :
                if Player.indexCountHelper == 0 {
                    attackEnnemy(inTeam: 1)
                }
                else {
                    attackEnnemy(inTeam: 0)
                }
                
            default: print("Merci de taper un chiffre correspondant à l'une des deux options.")
            chooseCharacterAction()
            }
        }
    }
    
    
    // TODO: Faire en sorte que l'action "healAlly" soit bloquée pour l'utilisateur si son personnage a déjà son maxHp.
    // TODO: faire en sorte que si un character a 93/100 hp et qu'il se fait soigner pour 25 HP, le programme ne bloque pas la fonction "healAlly" mais ajoute seulement la différence et affiche plutôt "Ton personnage récupère 7 hp !"
    
    func heal(characterNumber: Int) {
        if squad.indices.contains(characterNumber) {
            if squad[characterNumber].hp <= squad[characterNumber].maxHp - 25 { // Si les HP actuels du character ont un écart supérieur ou égal à 25 comparé à son maxHP, ajouter 25 HP.
                squad[characterNumber].hp += 25
                print("\(squad[characterNumber].characterName) récupère 25 points de vie ! \(squad[characterNumber].characterName) a désormais \(squad[characterNumber].hp) hp\n")
            } else if squad[characterNumber].hp == squad[characterNumber].maxHp {
                print("\nCe personnage a déjà le maximum de points de vie. Soigne un autre membre de ton escouade ou effectue une autre action.\n\n")
                healAlly()
            } else { // Si les HP actuels du character ont un écart inférieur à 25 HP, ajouter seulement la différence pour atteindre le maxHP.
                print("\(squad[characterNumber].characterName) récupère \(squad[characterNumber].maxHp - squad[characterNumber].hp) points de vie !")
                squad[characterNumber].hp += squad[characterNumber].maxHp - squad[characterNumber].hp
                print(" \(squad[characterNumber].characterName) a désormais \(squad[characterNumber].maxHp) hp\n")
            }
        } else {
            print("Bien essayé ! Séléctionne un héros vivant.")
            healAlly()
        }
        
    }
    
    func healAlly() {
        
        print("Quel allié veux-tu soigner ?\n")
        for (index, character) in squad.enumerated() {
            print("\(index+1). Soigner \(character.characterName) ton \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
        }
        print("0. Effectuer une autre action")
        
        if let choice = readLine() {
            switch choice {
                // FIXME: faire en sorte que le Joueur ne puisse plus séléctionner le case 1, case 2 ou case 3 si l'un des characters correspondants est mort et retiré du squad.
            case "1" :
                heal(characterNumber: 0)
            case "2" :
                heal(characterNumber: 1)
            case "3" :
                heal(characterNumber: 2)
            case "0" :
                chooseCharacterAction()
                
            default :
                print("\nMerci de saisir un chiffre correspondant à l'un des personnages de ton escouade, ou taper '0' puis 'Entrée' pour effectuer une autre action.\n\n")
                healAlly()
            }
            
        }
    }
    
    
    func attackEnnemy(inTeam teamIndex: Int) {
        print("Quel ennemi veux-tu attaquer ?")
        for (index, character) in game.players[teamIndex].squad.enumerated() {
            print("\(index+1). Attaquer \(character.characterName) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
        }
        print("0. Effectuer une autre action")
        
        if let choice = readLine() {
            switch choice {
                // FIXME:
            case "1" : attack(characterNumber: 0, inTeam: teamIndex)
            case "2" : attack(characterNumber: 1, inTeam: teamIndex)
            case "3" : attack(characterNumber: 2, inTeam: teamIndex)
            case "0" : chooseCharacterAction()
            default: print("Merci de saisir un chiffre correspondant à l'action souhaitée")
            attackEnnemy(inTeam: teamIndex)
            }
            
        }
    }
    
    func attack(characterNumber: Int, inTeam teamIndex: Int) {
        if game.players[teamIndex].squad.indices.contains(characterNumber) {
            game.players[teamIndex].squad[characterNumber].hp -= 25
            print("\nTon héros frappe \(game.players[teamIndex].squad[characterNumber].characterName) pour 25 de dégâts !")
            if game.players[teamIndex].squad[characterNumber].hp > 0 {
                print("\(game.players[teamIndex].squad[characterNumber].characterName) a désormais \(game.players[teamIndex].squad[characterNumber].hp)/\(game.players[teamIndex].squad[characterNumber].maxHp) hp\n")
            } else {
                print("\(game.players[teamIndex].squad[characterNumber].characterName) n'a plus aucun point de vie. \(game.players[teamIndex].squad[characterNumber].characterName) est retiré de l'escouade !")
                removeDeads(inTeam: teamIndex, characterNumber: characterNumber)
            }
        } else {
            print("Les fantômes ne peuvent pas tenir une arme !")
            attackEnnemy(inTeam: teamIndex)
        }
    }
    
    func removeDeads(inTeam teamIndex: Int, characterNumber: Int) {
        game.players[teamIndex].deadSquadMembers.append(game.players[teamIndex].squad[characterNumber])
        game.players[teamIndex].squad.remove(at: characterNumber)
    }
    
    //   print("""
    
    // """)
}
/* class Player {
 
 var playerName = String()
 
 var squad = [String]()
 
 func createMySquad() {
 
 while squad.count < 3 {
 print("Choisis le personnage numero \(squad.count+1) parmi les suivants :"
 + "\n1. Magicien"
 + "\n2. Chevalier"
 + "\n3. Dragon"
 + "\n4. Druide"
 + "\n5. Sorcière")
 let userInput = readLine()
 let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespaces)
 if let choice = trimmedUserInput {
 switch choice {
 case "1" :
 chooseNameOfCharacter(typeOfCharacter: "Magicien")
 case "2" :
 chooseNameOfCharacter(typeOfCharacter: "Chevalier")
 case "3" :
 chooseNameOfCharacter(typeOfCharacter: "Dragon")
 case "4" :
 chooseNameOfCharacter(typeOfCharacter: "Druide")
 case "5" :
 chooseNameOfCharacter(typeOfCharacter: "Sorcière")
 default: print("Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
 }
 }
 }
 }
 
 func chooseNameOfCharacter(typeOfCharacter: String) {
 print("\nTu as choisi le \(typeOfCharacter), comment veux tu l'appeler ?")
 let charactersName = readLine()
 if Character.charactersNames.contains(charactersName!) {
 print("Ce nom est déjà pris.")
 chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
 }
 /* else if squad.contains(charactersName!) {
 print("Ce nom est déjà pris.")
 chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
 } */
 
 else { //
 let character = Character()
 Character.charactersNames.append(charactersName!)
 squad.charactersNames.append(charactersName!)
 print("Adjugé vendu ! Ton \(typeOfCharacter) se nommera \(charactersName!) !\n")
 }
 }
 
 
 // comment afficher dans fight les persos sélectionner dans createMySquad ?!
 
 
 */



/* func chooseNameOfCharacter(typeOfCharacter: String) {
 print("Tu as choisi le \(typeOfCharacter), comment veux tu l'appeler ?")
 if squad.isEmpty {
 squad.append(readLine()!)
 print("le nom de ton héros est bien enregistré")
 } else {
 for name in squad {
 let userinput = readLine()
 if userinput != name {
 squad.append(userinput!)
 print("le nom de ton héros est bien enregistré")
 
 
 } else {
 print("Ce nom est déjà pris.")
 chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
 }
 }
 }
 }
 */


/* class Player {
 
 var playerName = String()
 var squad = [String]()
 var typesOfCharacters = [String: String]()
 func createMySquad() {
 
 while squad.count < 3 {
 print("Choisis le personnage numero \(squad.count+1) parmi les suivants :"
 + "\n1. Magicien"
 + "\n2. Chevalier"
 + "\n3. Dragon"
 + "\n4. Druide"
 + "\n5. Sorcière")
 let userInput = readLine()
 let trimmedUserInput = userInput?.trimmingCharacters(in: .whitespaces)
 if let choice = trimmedUserInput {
 switch choice {
 case "1" :
 chooseNameOfCharacter(typeOfCharacter: "Magicien")
 case "2" :
 chooseNameOfCharacter(typeOfCharacter: "Chevalier")
 case "3" :
 chooseNameOfCharacter(typeOfCharacter: "Dragon")
 case "4" :
 chooseNameOfCharacter(typeOfCharacter: "Druide")
 case "5" :
 chooseNameOfCharacter(typeOfCharacter: "Sorcière")
 default: print("Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
 }
 }
 }
 }
 
 func chooseNameOfCharacter(typeOfCharacter: String) {
 print("\nTu as choisi le \(typeOfCharacter), comment veux tu l'appeler ?")
 let charactersName = readLine()
 if Character.charactersNames.contains(charactersName!) {
 print("Ce nom est déjà pris.")
 chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
 }
 else if squad.contains(charactersName!) {
 print("Ce nom est déjà pris.")
 chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
 }
 
 else {
 Character.charactersNames.append(charactersName!)
 squad.append(charactersName!)
 print("Adjugé vendu ! Ton \(typeOfCharacter) se nommera \(charactersName!) !\n")
 }
 }
 
 */
