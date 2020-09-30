//
//  Game.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Game {
    
    // ⬇︎ Nombre de joueurs maximum prévus pour ce jeu
    let maxNumberOfPlayers = 2
    
    // ⬇︎ Tableau contenant des instances de la classe Player, correspondants au nombre de joueurs en jeu
    var players: [Player] = []
    
    // ⬇︎ Compteur de rounds
    static var roundCount = 0
    
    
    // ⬇︎ Fonction permettant de créer un joueur et de lui faire choisir un nom, puis d'enchainer sur la création de son escouade de 3 characters
    func createPlayer() {
        // Ajout d'une instance de Player au tableau players
        let player = Player()
        players.append(player)
        
        print("Joueur \(players.count) ! A toi de choisir un nom d'équipe :")
        players[players.count-1].name = readLine()!
        print("\nTrès bien équipe \(players[players.count-1].name), forme ton escouade de 3 personnages !\n")
    }
    
    
    // ⬇︎ Pour chaque joueur, appelle la fonction de création d'escouade
    private func createTeams() {
        for player in players {
            player.createMySquad()
        }
    }
    
    
    // ⬇︎ Permet d'appeler les fonctions d'initialisation du jeu : message de bienvenue, création des profils joueurs et création de leur escouades respectives.
    func startGame() {
        print("Bienvenue dans le jeu de combat le plus féroce de l'histoire !\n")
        for _ in 1...maxNumberOfPlayers {
            createPlayer()
            createTeams()
        }
        startRound()
        
    }
    
    // ⬇︎ Phase de combat. Appelle les fonctions suivantes : choix du character pour le round par l'utilisateur
    private func startRound() {
        // ⬇︎ Variable permettant d'appeler les index au tour par tour en fonction du nombre de joueurs
        while players[0].squad.count != 0 && players[1].squad.count != 0 {
        for player in players {
            if players[0].squad.count != 0 && players[1].squad.count != 0 {
            player.pickFighters()
            player.chooseCharacterAction()
            Player.indexCountHelper += 1
            } else {
                endOfGame()
            }
        }
        Player.indexCountHelper = 0
        Game.roundCount += 1
        }
        
    }
    
    
    
    
    func endOfGame() {
        print("\n\n Ho ho... Nous avons un VAINQUEUR !\n\n")
        if players[0].squad.count > players[1].squad.count {
            print("L'équipe \(players[0].name) gagne la partie !")
            players[0].didIWin = "VAINQUEUR"
        } else {
            print("L'équipe \(players[1].name) gagne la partie !")
            players[1].didIWin = "VAINQUEUR"
        }
        gameStats()
        
        print("\n\n Statistiques des personnages de l'équipe \(players[0].name):\n")
        squadStats(teamIndex: 0)
        print("\n\n Statistiques des personnages de l'équipe \(players[1].name):\n")
        squadStats(teamIndex: 1)
    }
    
    func gameStats() {
        print("\n\nEt voici les statistiques du jeu :")
        
        print("\n\nÉquipe \(players[0].name) VS \(players[1].name)")
        print("\n\nNombre de tours : \(Game.roundCount+1)")
        print("\n\n\n ÉQUIPE \(players[0].name)")
        if players[0].didIWin != nil {
            print("(\(players[0].didIWin!))")
        }
        
    }
    
    func squadStats(teamIndex: Int) {
        charactersStats(teamIndex: teamIndex)
        
    }
    
    func charactersStats(teamIndex: Int) {
        if players[teamIndex].squad.isEmpty {
            print("\n-- Personnages morts --")
            for character in players[teamIndex].deadSquadMembers {
                print("\n • '\(character.characterName)'"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)"
                    + "\n- Total de dégats: \(character.totalDamages)\n\n")
            }
            
        } else {
            print("-- Survivants --")
            for character in players[teamIndex].squad {
                print("\n • \(character.characterName):"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)"
                    + "\n- Dommages totaux: \(character.totalDamages)\n\n")
            }
            
            print("-- Personnages morts --")
            for character in players[teamIndex].deadSquadMembers {
                print("\n • \(character.characterName):"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)"
                    + "\n- Dommages totaux: \(character.totalDamages)\n\n")
            }
            
        }
    }
    
}
/* func roundFight() {
 //  while players[0].squad.count > 0 || players[1].squad.count > 0 {
 print("\n\nROUND \(Game.roundCount+1)\n\n")
 players[0].pickFighters()
 fight()
 print("\n\nROUND \(Game.roundCount+1)\n\n")
 print("Équipe \(players[1].name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre le round numéro \(Game.roundCount+1)")
 players[1].pickFighters()
 fight()
 }
 // }
 */
/* for number in playerNumber {
 if number == 1 {
 print("Bienvenue à toi, jeune aventurier ! Tu seras le meneur de l'équipe \(playerNumber[0]). Choisis un nom d'équipe :")
 playerName.insert(readLine()!, at: 0)
 print("Très bien, \(playerName[0]). Que la force soit avec toi.")
 }
 else if number == 2 {
 print("Et maintenant, que le meneur de l'équipe \(playerNumber[1]) s'avance ! À ton tour de choisir un nom d'équipe :")
 playerName.insert(readLine()!, at: 1)
 print("Très bien, \(playerName[1]). Pour le Gondor !")
 }
 } */





//choix du character par le player parmi le squad
//print("Sélectionne le personnage que tu souhaites faire combattre"
// + "\n1. Magicien
//+ "\n2. Chevalier
//+ \n3. Dragon

// puis éxécuter
// return playershp += damage


//if let choice = readline() {
// switch choice {
//case "1" : Character.magicien(p: 100, weapon: "Baguette magique")
//case "2" : Character.chevalier() //même chose sur les lignes d'en dessous
//case "3" : Character.dragon()
//case "4" : Character.druide()
//case "5" : Character.sorcière()
// }
//}


// ANCIEN EMPLACEMENT DE LAUNCHGAME(), REMETTRE ICI SI BUG


// Peut-être que pour endOfGame oon fait plutôt une fonction qui affiche les stats de la partie +gagnants et non une variable ?
//func endOfGame() {
//print("this winner's round is \(winner) !")
//init(winner: String) {
//self.winner = winner
//}

//Fonction pour définir winner :
// func winner() {
// if player1.hp > player2.hp {
//print ("\(players1) won the game")
//}
// else {
// print("\(player2) won the game")
//}


/* class Game {
 
 
 let maxNumberOfPlayers = 2
 var players: [Player] = []
 
 func createPlayers() {
 let player = Player()
 players.append(player)
 }
 
 func createTeams() {
 /* Assigner les équipes */
 for player in players {
 player.createMySquad()
 }
 }
 
 func startGame() {
 for playerNumber in 1...maxNumberOfPlayers {
 print("Bienvenue, jeune aventurier !")
 createPlayers()
 createTeams()
 }
 
 */

