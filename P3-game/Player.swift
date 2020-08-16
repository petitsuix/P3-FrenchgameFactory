//  Player.swift
//  P3-game
//
//  Created by Manon Russo on 27/07/2020.
//  Copyright © 2020 Manon Russo. All rights reserved.
//

import Foundation

class Player {
    
    var name = String()
    
    // ⬇︎ Tableau contenant les instances de la classe Character, correspondants aux 3 personnages de chaque joueur
    var squad: [Character] = []
    
    // ⬇︎ Création des escouades de 3 personnages par le joueur. Dans la limite de 3, ajout des instances Character, choix du type de personnage puis d'un nom unique par l'utilisateur.
    func createMySquad() {
        while squad.count < 3 {
            let character = Character()
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
                    /* Chaque cas permet, dans l'ordre :
                     • d'ajouter une instance de Character au tableau [squad]
                     • d'appeler la fonction chooseNameOfCharacter dont le paramètre correspond au type (druide, magicien, dragon...) respectif de chaque personnage
                     • d'assigner une valeur à la variable "characterType" correspondant au type (druide, magicien, dragon...) de personnage choisi
                     */
                case "1" :
                    squad.append(character)
                    chooseNameOfCharacter(typeOfCharacter: "Magicien")
                    character.characterType = "Magicien"
                case "2" :
                    squad.append(character)
                    chooseNameOfCharacter(typeOfCharacter: "Chevalier")
                    character.characterType = "Chevalier"
                case "3" :
                    squad.append(character)
                    chooseNameOfCharacter(typeOfCharacter: "Dragon")
                    character.characterType = "Dragon"
                case "4" :
                    squad.append(character)
                    chooseNameOfCharacter(typeOfCharacter: "Druide")
                    character.characterType = "Druide"
                case "5" :
                    squad.append(character)
                    chooseNameOfCharacter(typeOfCharacter: "Sorcière")
                    character.characterType = "Sorcière"
                default: print("Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
                }
            }
        }
    }
    
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir le nom de chacun de ses trois personnages.
    func chooseNameOfCharacter(typeOfCharacter: String) {
        print("\nTu as choisi le \(typeOfCharacter), comment veux tu l'appeler ?")
        let userInput = readLine()
        if Character.charactersNames.contains(userInput!) {
            print("Ce nom est déjà pris.")
            chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
        }
            /* else if squad.contains(charactersName!) {
             print("Ce nom est déjà pris.")
             chooseNameOfCharacter(typeOfCharacter: typeOfCharacter)
             } */
            
        else { // FIXME: faire en sorte que ça déballe de manière safe + trimming
            Character.charactersNames.append(userInput!) // On ajoute le nom au tableau récapitulatif de tous les noms
            squad[squad.count-1].characterName = userInput!
            print("Adjugé vendu ! Ton \(typeOfCharacter) se nommera \(userInput!) !\n")
        }
    }
    
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir le personnage avec lequel il souhaite combattre pour le round en cours
    func pickFighters() {
        print("Équipe \(name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre pendant le round \(Game.roundCount+1) :"
            + "\n1. \(squad[0].characterName) le \(squad[0].characterType)"
            + "\n2. \(squad[1].characterName) le \(squad[1].characterType)"
            + "\n3. \(squad[2].characterName) le \(squad[2].characterType)")
        if let choice = readLine() {
            switch choice {
            case "1" :
                print("Tu as choisi de jouer avec \(squad[0].characterName), ton \(squad[0].characterType)")
            case "2" :
                print("Tu as choisi de jouer avec \(squad[1].characterName), ton \(squad[1].characterType)")
            case "3" :
                print("Tu as choisi de jouer avec \(squad[2].characterName), ton \(squad[2].characterType)")
            default:
                print("Ce héros n'existe pas. Tape un chiffre entre 1 et 3 puis appuie sur 'Entrée'.")
            }
        }
        
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
             
         else { // FIXME: faire en sorte que ça déballe de manière safe + trimming
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
