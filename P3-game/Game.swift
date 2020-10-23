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
    
    var allPlayerNames: [String] = []
    
    // ⬇︎ Compteur de rounds
    static var roundCount = 0
    
    // ⬇︎ Permet d'appeler les fonctions d'initialisation du jeu : message de bienvenue, création des profils joueurs et création de leur escouade respective. Cette fonction appelle également le commencement de la phase de jeu avec startPlaying.
    func startGame() {
        print("🛡 Bienvenue dans le jeu de combat le plus féroce de l'histoire ! 🛡\n")
        for _ in 1...maxNumberOfPlayers {
            createPlayer()
            createTeams()
        }
        startPlaying()
        
    }
    // ⬇︎ Fonction permettant de créer un joueur et de lui faire choisir un nom, puis d'enchainer sur la création de son escouade de 3 characters
    private func createPlayer() {
        // Ajout d'une instance de Player au tableau players
        let player = Player()
        
        
        print("\n\n👑 Joueur \(players.count+1) 👑 A toi de choisir un nom d'équipe :")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Si userInput est égale à readLine (qu'on trimme au passage), et si elle n'est pas vide :
            if allPlayerNames.contains(userInput) { // On vérifie dans le tableau récapitulatif de tous les noms si ce dernier existe déjà
                print("Ce nom est déjà pris.")
                createPlayer()
            } else {
                players.append(player)
                player.name = userInput
                allPlayerNames.append(userInput)
                print("Très bien équipe \(player.name).")
            }
        } else {
            print("Choisis un nom valide")
            createPlayer()
        }
    }
    
    
    // FIXME: Cette fonction est-elle à la bonne place ? Eventuellement la déplacer dans la classe Player ? Comment faire sachant que le tableau players se trouve ici dans Game ?
    // ⬇︎ Pour chaque joueur, appelle la fonction de création d'escouade
    func createTeams() {
        print("\nForme ton escouade de 3 personnages 🧍🏽‍♂️\n")
        for player in players {
            player.createMySquad()
        }
    }
    
    
    
    // ⬇︎ Début de la phase de jeu/d'actions
    private func startPlaying() {
        // ⬇︎ Tant que l'une de ces deux conditions est vraie, commencer un round.
        while players[0].squad.count != 0 && players[1].squad.count != 0 {
            print("\n\n⚔️【 ROUND \(Game.roundCount+1) 】⚔️\n\n\n")
            for player in players {
                if players[0].squad.count == 0 || players[1].squad.count == 0 {
                    // ⬆︎ On revérifie si les conditions sont toujours vraies pour ne pas parcourir l'ensemble de la boucle dans le cas ou le joueur 1 gagne en premier (sinon le joueur 1 gagne, mais le programme continue la boucle, et le joueur 2 peut encore jouer son tour à ce round).
                    endOfGame()
                } else {
                    player.pickFighters()
                    player.chooseCharacterAction()
                }
                
                Player.indexCountHelper += 1
            }
            // ⬇︎ Fin du round, la valeur de indexCountHelper est remise à zéro et le compteur de round prend +1.
            Player.indexCountHelper = 0
            Game.roundCount += 1
        }
        
    }
    
    
    
    // ⬇︎ Fin du combat. Apparaît lorsque l'un des tableaux "squad" est vide. Affiche le vainqueur et les stats de partie.
    private func endOfGame() {
        print("\n\n Ho ho... Nous avons un VAINQUEUR ! 🎉\n\n")
        if players[0].squad.count > players[1].squad.count {
            print("🏆 L'équipe \(players[0].name) gagne la partie 🏆")
        } else {
            print("🏆 L'équipe \(players[1].name) gagne la partie 🏆")
        }
        gameStats()
        
        print("\n\n🙋 Statistiques des personnages de l'équipe \(players[0].name):\n")
        charactersStats(teamIndex: 0)
        print("\n\n🙋 Statistiques des personnages de l'équipe \(players[1].name):\n")
        charactersStats(teamIndex: 1)
    }
    
    // ⬇︎ Stats de partie
    private func gameStats() {
        print("\n\n📈 Et voici les statistiques du jeu :")
        
        print("\n\n• 🤼 Équipe \(players[0].name) VS \(players[1].name)")
        print("\n• ⟳ Nombre de tours : \(Game.roundCount+1)\n")
        
    }
    
    // ⬇︎ Stats des personnages des escouades
    private func charactersStats(teamIndex: Int) {
        
        // Si le tableau squad d'un joueur est vide, c'est que tous ses personnages sont morts.
        if players[teamIndex].squad.isEmpty {
            print("\n-- ☠️ Personnages morts ☠️ --")
            for character in players[teamIndex].deadSquadMembers {
                print("\n • '\(character.name)'"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)")
            }
            // Si le tableau squad d'un joueur n'est pas vide, c'est qu'il lui reste des survivants dans son escouade.
        } else {
            print("-- ⭐️ Survivants ⭐️ --")
            for character in players[teamIndex].squad {
                print("\n • '\(character.name)'"
                    + "\n- Classe: \(character.characterType)"
                    + "\n- Points de vie: \(character.hp)")
            }
            
            // Si jamais le joueur dont il est question est vraiment un boss et qu'il lui reste toujours ses 3 héros en fin de partie, on fait en sorte que la rubrique "personnages morts" ne s'affiche pas dans les stats :
            if players[teamIndex].squad.count != 3 {
                print("\n-- ☠️ Personnages morts ☠️ --")
                for character in players[teamIndex].deadSquadMembers {
                    print("\n • '\(character.name)'"
                        + "\n- Classe: \(character.characterType)"
                        + "\n- Points de vie: \(character.hp)")
                }
            }
        }
    }
    
}

