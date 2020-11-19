//
//  Game.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Game {
    
// MARK: - Public properties
    
    var roundCount = 0
    
// MARK: - Private properties
    
    // ⬇︎ Contains Player instances, relating to the number of players in game.
    private var players: [Player] = []
    
    // ⬇︎ Helper property that allows the programm to go through the existing values and verify that player names are unique
    private var allPlayerNames: [String] {
        var names: [String] = []
        for player in players {
            names.append(player.name)
        }
        return names
    }
    
// MARK: - Public methods
    
    // ⬇︎ Calls game initialisation methods : welcome message, creation of players, creation of their respective team (squad). Also calls the playing phase with battleRounds, and the endOfGame method.
    func startGame() {
        print("🛡 Bienvenue dans le jeu de combat le plus féroce de l'histoire ! 🛡\n")
        for _ in 1...2 {
            createPlayer()
            createTeams()
        }
        battleRounds()
        endOfGame()
    }
    
// MARK: - Private methods
    
    // ⬇︎ Creates a player with a unique name.
    private func createPlayer() {
        
        let player = Player()
        print("\n\n👑 Joueur \(players.count+1) 👑 A toi de choisir un nom d'équipe :")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Unwrap if conditions are met
            if allPlayerNames.contains(userInput) { // Verify that this name is not taken already
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
    
    // ⬇︎ For every player, calls the createMySquad method
    private func createTeams() {
        print("\nForme ton escouade de 3 personnages 🧍🏽‍♂️\n")
        for player in players {
            player.createMySquad()
        }
    }
    
    // ⬇︎ One round. Action phase.
    private func battleRounds() {
        // ⬇︎ As long as both conditions are false, starts a new round
        while players[0].squadIsDead == false && players[1].squadIsDead == false {
            
            print("\n\n⚔️【 ROUND \(roundCount+1) 】⚔️\n\n\n")
            for player in players {
                if player.squadIsDead == false { // ‣ Ensures that the condition is still false so the loop ends here if player 1 wins
                    
                    let opponent = players.filter { player.name != $0.name }[0] // ‣ Identifies the opponent so the programm understands which squad to display (through downstream parameters) during combat phase
                    player.pickFighter()
                    player.chooseFighterAction(ennemySquad: opponent.squad)
                }
            }
            roundCount += 1
        }
    }
    
    // ⬇︎ Displays winner and end-game stats
    private func endOfGame() {
        declareWinner()
        displayStats()
    }
    
    private func declareWinner() {
        print("\n\n Ho ho... Nous avons un VAINQUEUR ! 🎉\n\n")
        if players[0].aliveSquadCharacters.count > players[1].aliveSquadCharacters.count {
            print("🏆 L'équipe \(players[0].name) gagne la partie 🏆")
        } else {
            print("🏆 L'équipe \(players[1].name) gagne la partie 🏆")
        }
    }
    
    // ⬇︎ Displays game stats
    private func displayStats() {
        print("\n\n📈 Et voici les statistiques du jeu :")
        print("\n\n• 🤼 Équipe \(players[0].name) VS \(players[1].name)")
        print("\n• ⟳ Nombre de tours : \(roundCount+1)\n")
        // ⬇︎ Displays characters stats
        for player in players {
            print("\n\n\n🙋 Statistiques des personnages de l'équipe \(player.name):\n")
            print("\n-- ☠️ Personnages morts ☠️ --")
            for character in player.squad where character.hp == 0 {
                charactersStats(character: character)
                // character.stats
            }
            if player.aliveSquadCharacters.count > 0 { // For better clarity, shows only if player still has alive characters
                print("\n\n-- ⭐️ Survivants ⭐️ --")
                for character in player.aliveSquadCharacters {
                    charactersStats(character: character)
                }
            }
        }
    }
    
    private func charactersStats(character: Character) {
        print("\n • '\(character.name)'"
                + "\n- Classe: \(character.characterType)"
                + "\n- Points de vie: \(character.hp)")
    }
}
