//
//  Game.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Game {
    
    // ⬇︎ Tableau contenant des instances de la classe Player, correspondants au nombre de joueurs en jeu
    private var players: [Player] = []
    
    // ⬇︎ Helper property
    private var allPlayerNames: [String] {
        var names: [String] = []
        for player in players {
            names.append(player.name)
        }
        return names
    }
    
    // ⬇︎ Compteur de rounds
    var roundCount = 0
    
    // ⬇︎ Permet d'appeler les fonctions d'initialisation du jeu : message de bienvenue, création des profils joueurs et création de leur escouade respective. Cette fonction appelle également le commencement de la phase de jeu avec startPlaying.
    func startGame() {
        print("🛡 Bienvenue dans le jeu de combat le plus féroce de l'histoire ! 🛡\n")
        for _ in 1...2 {
            createPlayer()
            createTeams()
        }
        gameCorePhases()
        endOfGame()
    }
    
    // ⬇︎ Fonction permettant de créer un joueur et de lui faire choisir un nom, puis d'enchainer sur la création de son escouade de 3 characters
    private func createPlayer() {
        
        let player = Player()
        
        print("\n\n👑 Joueur \(players.count+1) 👑 A toi de choisir un nom d'équipe :")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Si userInput est égale à readLine trimmée, et si elle n'est pas vide :
            if allPlayerNames.contains(userInput) { // On vérifie dans le tableau récap des noms si ce dernier existe déjà
                print("Ce nom est déjà pris.")
                createPlayer()
            } else {
                players.append(player)
                player.name = userInput
                print("Très bien équipe \(player.name).")
            }
        } else {
            print("Choisis un nom valide")
            createPlayer()
        }
    }
    
    // ⬇︎ Pour chaque joueur, appelle la fonction de création d'escouade
    private func createTeams() {
        print("\nForme ton escouade de 3 personnages 🧍🏽‍♂️\n")
        for player in players {
            player.createMySquad()
        }
    }
    
    // ⬇︎ Corps du jeu (rounds, attaque/soin)
    private func gameCorePhases() {
        
        // ⬇︎ Tant que ces deux conditions sont vraies, commencer un round.
        while players[0].squadIsDead == false && players[1].squadIsDead == false {
            print("\n\n⚔️【 ROUND \(roundCount+1) 】⚔️\n\n\n")
            for player in players {
                if player.squadIsDead == false { // ‣ On revérifie que la condition est toujours vraie au cas ou le joueur 1 gagne, de manière à ce que la boucle ne continue pas avec le joueur 2 s'il n'a plus de personnages vivants
                    
                    let opponent = players.filter { player.name != $0.name }[0] // ‣ On définit l'adversaire pour donner au programme la possibilité d'aller chercher le squad adverse lorsque le joueur dont c'est le tour choisira d'attaquer.
                    player.pickFighter()
                    player.chooseFighterAction(characters: opponent.aliveSquadCharacters) //
                }
            }
            // ⬇︎ Fin du round, le compteur de round prend +1.
            roundCount += 1
        }
    }
    // ⬇︎ Fin du combat. Apparaît lorsque squadIsDead est vrai chez l'un des joueurs. Affiche le vainqueur et les stats de partie.
    func endOfGame() {
        print("\n\n Ho ho... Nous avons un VAINQUEUR ! 🎉\n\n")
        if players[0].aliveSquadCharacters.count > players[1].aliveSquadCharacters.count {
            print("🏆 L'équipe \(players[0].name) gagne la partie 🏆")
        } else {
            print("🏆 L'équipe \(players[1].name) gagne la partie 🏆")
        }
        gameStats()
        charactersStats()
    }
    
    // ⬇︎ Stats de partie
    private func gameStats() {
        print("\n\n📈 Et voici les statistiques du jeu :")
        
        print("\n\n• 🤼 Équipe \(players[0].name) VS \(players[1].name)")
        print("\n• ⟳ Nombre de tours : \(roundCount+1)\n")
    }
    
    
    // ⬇︎ Stats des personnages
    private func charactersStats() {
        
        for player in players {
            
            print("\n\n\n🙋 Statistiques des personnages de l'équipe \(player.name):\n")
            
            print("\n-- ☠️ Personnages morts ☠️ --")
            for character in player.squad where character.hp == 0 {
                print("\n • '\(character.name)'"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)")
            }
            if player.aliveSquadCharacters.count > 0 { // Cette section s'affiche uniquement si le joueur a des characters encore vivants, par soucis de lisibilité.
                print("\n\n-- ⭐️ Survivants ⭐️ --")
                for character in player.aliveSquadCharacters {
                    print("\n • '\(character.name)'"
                        + "\n- Classe: \(character.characterType)"
                        + "\n- Points de vie: \(character.hp)")
                }
            }
        }
    }
}

