//  Player.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Player {
    
    var name = String()
    
    // ⬇︎ Tableau contenant les instances de la classe Character, correspondants aux 3 personnages de chaque joueur
    var squad: [Character] = []
    
    // ⬇︎ Tableau des personnages morts qui se remplit au fur et à mesure que les membres du tableau squad sont supprimés en jeu.
    var deadSquadMembers: [Character] = []
    
    
    // ⬇︎ Propriété permettant de garder une référence au character choisi par le joueur pour le round en cours (donne la possibilité, entre autres, de jouer avec les valeurs des dégâts des armes de chaque character, et de leur redonner une valeur par défaut si besoin)
    private var fightingCharacter = Character(name: "")
    
    // ⬇︎ La valeur de chestChances déterminera si un coffre apparaît devant le personnage, ou non.
    private var chestChances = Int()
    
    // ⬇︎ Les nouveaux dégâts infligés par le héros grâce à l'arme trouvée dans le coffre.
    private var newDamagesRandom = Int()
    
    // ⬇︎ Permet au programme d'aller chercher et d'attaquer l'escouade adverse en changeant l'index du tableau de Players. Elle est statique pour pouvoir l'utiliser dans la classe Game, dans la fonction "startPlaying": on lui ajoute 1 à chaque tour de boucle "for player in [players]" et lorsque la boucle est terminée (signifiant la fin du round 1) et que les deux joueurs ont chacun effectué leur action, indexCountHelper est remis à 0 pour être réutilisé au round suivant.
    static var indexCountHelper = 0
    
    
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
                /* Chaque cas permet, dans l'ordre :
                 • d'ajouter une instance de Character au tableau [squad]
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
            default: print("🤕 Merci de taper un chiffre entre 1 et 5 pour choisir le personnage correspondant")
            }
        }
    }
    
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir un nom unique pour chacun de ses trois personnages.
    private func chooseName(of type: String) {
        print("\nTu as opté pour un \(type) choisis-lui un nom 🏷")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty { // Si userInput est égale à readLine (qu'on trimme au passage), et si elle n'est pas vide :
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
    
    // ⬇︎ Fonction permettant à l'utilisateur de choisir le personnage avec lequel il souhaite effectuer une action pour le round en cours
    func pickFighters() {
        removeDeadPlayers()
        print("🎲 Équipe \(name), saisis un chiffre correspondant au personnage avec lequel tu souhaites combattre pendant le round \(Game.roundCount+1) :\n")
        // ⬇︎ Affiche une liste des personnages vivants et disponibles dans l'escouade.
        for (index, character) in squad.enumerated() {
            print("\(index+1). \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
        }
        if let choice = readLine() {
            switch choice {
            case "1" : // peut-être qu'utiliser "where" + condition après chaque "case" est mieux que ".indices.contains()"
                choosenFighter(characterNumber: 0)
            case "2" :
                choosenFighter(characterNumber: 1)
            case "3" :
                choosenFighter(characterNumber: 2)
            default:
                print("\n🚣‍♀️ Ce héros n'existe pas. Tape un chiffre correspondant puis appuie sur 'Entrée'.")
                pickFighters()
            }
        }
        
    }
    
    private func choosenFighter(characterNumber: Int) {
        if squad.indices.contains(characterNumber) { // ‣ Permet de sécuriser la saisie, dans le cas ou l'utilisateur souhaiterait appeler un personnage déjà éliminé.
            fightingCharacter = squad[characterNumber] // ‣ On mémorise quel personnage va au combat pour ce round
            print("\nTu as choisi de jouer avec \(fightingCharacter.name), ton \(fightingCharacter.characterType)")
            chest() // ‣ évènement aléatoire
        } else {
            print("\n🚣‍♀️ Choisis un personnage qui est encore vivant !")
            pickFighters()
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
    
//    // ⬇︎ Fait apparaître un coffre, juste après que le joueur ait choisi son combattant. 5 fois sur 10. Le coffre contient des armes elfiques de différents types en fonction des dommages, qui varieront entre 10 et 80. Une arme elfique du même type pourra donc être plus ou moins puissante.
//    private func chest() {
//        newDamagesRandom = Int.random(in: 10...80) // ‣ assigne à la propriété une nouvelle valeur aléatoire à chaque appel de chest()
//        chestChances = Int.random(in: 1...10) // ‣ chances de voir un coffre apparaître
//        if chestChances <= 5 {
//            print("\nAttends voir... 🧝‍♂️✨🧝 Les elfes t'ont fait parvenir un coffre ! Voyons ce qu'il y a dedans... 🔍")
//            if newDamagesRandom <= 25 {
//                print("\nIl contient une dague elfique éthérée 🗡 Celle-ci inflige \(newDamagesRandom) points de dégâts !")
//                keepChestWeaponOrNot() // ‣ Demande au joueur s'il souhaite garder l'arme trouvée
//            } else if newDamagesRandom > 25 && newDamagesRandom <= 50 {
//                print("\nIl contient une épée elfique éthérée 🗡 Celle-ci inflige \(newDamagesRandom) points de dégâts !")
//                keepChestWeaponOrNot()
//            } else if newDamagesRandom > 50 && newDamagesRandom <= 70 {
//                print("\nIl contient un arc elfique éthéré 🏹 Celui-ci inflige \(newDamagesRandom) points de dégâts !")
//                keepChestWeaponOrNot()
//            } else {
//                print("\nIl contient un bâton de sorcier elfique éthéré 🦯✨ Celui-ci inflige \(newDamagesRandom) points de dégâts !")
//                keepChestWeaponOrNot()
//            }
//        } else {
//            fightingCharacter.weapon.damages = fightingCharacter.defaultCharacterDamages
//        }
//    }
    
    // ⬇︎ Méthode de confirmation de l'arme elfique
    private func keepChestWeaponOrNot(chestWeapon: Weapon) {
        print("\nVeux-tu t'en équiper pour ce tour ?\n\n"
            + "1. Oui 🙋\n"
            + "2. Non 🙅")
        if let choice = readLine() {
            switch choice {
            case "1" : // utiliser override ??
                // ‣ Oui: Les dommages actuels sont remplacés
                fightingCharacter.weapon = chestWeapon
                print("\nTrès bien, on la prend ! 🎒\n")
            case "2" :
                fightingCharacter.weapon.damages = fightingCharacter.defaultCharacterDamages // ‣ Non: On réattribue les dommages par défaut
                fightingCharacter.weapon.weaponType = fightingCharacter.defaultWeaponType
                print("\nTrès bien, on leur retourne le cadeau ! 💨")
            default :
                print("🚣‍♂️ Merci de saisir un chiffre correspondant à Oui ou Non.")
                keepChestWeaponOrNot(chestWeapon: chestWeapon)
            }
        }
    }
    
    func chooseCharacterAction(characters: [Character]) {
        
        print("🔔 Que veux-tu faire ?\n"
            + "\n1. Soigner un allié ⛑"
            + "\n2. Attaquer un membre de l'escouade adverse 🔪")
        if let choice = readLine() {
            switch choice {
            case "1" :
                healAlly(characters: characters)
            //
            case "2" :
                if Player.indexCountHelper == 0 {
                    attackEnnemy(characters: characters)
                    // TODO: remplacer index de attackEnnemy par un tableau (player ou autre) ?
                }
                else {
                    attackEnnemy(characters: characters)
                }
                
            default: print("🚣‍♀️ Merci de taper un chiffre correspondant à l'une des deux options.")
            chooseCharacterAction(characters: characters)
            }
        }
    }
    // FIXME: Pourquoi ne pas intégrer la fonction "heal" décrite plus bas à la fonction healAlly ? Idem pour les fonction relatives à attack.
    private func healAlly(characters: [Character]) {
        
        print("Quel allié veux-tu soigner ? 🏥\n")
        for (index, character) in squad.enumerated() {
            print("\(index+1). Soigner \(character.name) ton \(character.characterType) (\(character.hp)/\(character.maxHp) hp) \n")
        }
        print("0. Effectuer une autre action 🙇🏻‍♂️")
        
        if let choice = readLine() {
            switch choice {
            case "1" :
                heal(characterNumber: 0, characters: self.squad)
            case "2" :
                heal(characterNumber: 1, characters: self.squad)
            case "3" :
                heal(characterNumber: 2, characters: self.squad)
            case "0" :
                chooseCharacterAction(characters: characters) // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
                
            default :
                print("\n🚣‍♂️ Merci de saisir un chiffre correspondant à l'un des personnages de ton escouade, ou taper '0' puis 'Entrée' pour effectuer une autre action.\n\n")
                healAlly(characters: characters)
            }
            
        }
    }
    
    private func heal(characterNumber: Int, characters: [Character]) { // ‣ Lire la fonction avec paramètre comme suit : "Soigner caractère numéro: 0, 1 ou 2"
        let target = squad[characterNumber]
        if squad.indices.contains(characterNumber) {
            if target.hp <= target.maxHp - fightingCharacter.healSkill { // ‣ Si les HP actuels du character ciblé par le soin ont un écart supérieur ou égal au montant de la propriété HealSkill, comparé à son maxHP, ajouter ce montant en entier.
                target.hp += fightingCharacter.healSkill
                print("\(target.name) récupère \(fightingCharacter.healSkill) points de vie ♥️ \(target.name) a désormais \(target.hp) hp\n")
            } else if target.hp == target.maxHp { // ‣ Si les hp actuels du character sont déjà au maximum :
                print("\n🚣‍♂️ Ce personnage a déjà le maximum de points de vie. Soigne un autre membre de ton escouade ou effectue une autre action.\n\n")
                healAlly(characters: characters)
            } else { // ‣ Si les HP actuels du character ont un écart inférieur au montant de la compétence healskill, ajouter seulement la différence pour atteindre le maxHp.
                print("\(target.name) récupère \(target.maxHp - target.hp) points de vie ♥️")
                target.hp += target.maxHp - target.hp
                print(" \(target.name) a désormais \(target.maxHp) hp\n")
            }
        } else {
            print("🚣‍♂️ Bien essayé ! Séléctionne un héros vivant.")
            healAlly(characters: characters)
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
            case "1" : attack(character: characters[0]) // "Attaquer le character numéro: 0, dans l'équipe: 0 ou 1"
            case "2" : attack(character: characters[1])
            case "3" : attack(character: characters[2])
            case "0" : chooseCharacterAction(characters: characters) // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
            default: print("🚣‍♂️ Merci de saisir un chiffre correspondant à l'action souhaitée\n")
            attackEnnemy(characters: characters)
            }

        }
    }
  
//    private func attackEnnemy(player: Player) {
//        print("\n\nQuel ennemi veux-tu attaquer ? ⚔️\n")
//        for (index, character) in player.squad.enumerated() {
//            print("\(index+1). Attaquer \(character.name) le \(character.characterType) (\(character.hp)/\(character.maxHp) hp)\n")
//        }
//        print("0. Effectuer une autre action 🙇🏻‍♂️")
//
//        if let choice = readLine() {
//            switch choice {
//            case "1" : attack(player: player, characterNumber: 0) // "Attaquer le character numéro: 0, dans l'équipe: 0 ou 1"
//            case "2" : attack(player: player, characterNumber: 1)
//            case "3" : attack(player: player, characterNumber: 2)
//            case "0" : chooseCharacterAction() // ‣ Le joueur peut revenir au menu précédent s'il le souhaite.
//            default: print("🚣‍♂️ Merci de saisir un chiffre correspondant à l'action souhaitée\n")
//            attackEnnemy(player: player)
//            }
//
//        }
//    }
    
//    func attackBIS(ennemyCharacter: Character) {}
//
//    func attackTER(player: Player, characterNumber: Int) {}
        
        
//        if player.squad.indices.contains(characterNumber) {
//            player.squad[characterNumber].hp -= fightingCharacter.weapon.damages
//            print("\nTon héros frappe \(player.squad[characterNumber].name) pour \(fightingCharacter.weapon.damages) de dégâts ! 💔\n")
//        } else {
//            print("\n👻 Les fantômes ne peuvent pas tenir une arme !\n")
//            attackEnnemy(player: player)
//        }
//    }
    
    
    
    // ⬇︎ Comme pour la méthode heal, la propriété characterNumber permet d'aller chercher le personnage attaqué. La propriété inTeam, quant à elle, défini dans quelle équipe il faut aller le trouver.

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


    // ⬇︎ La grande faucheuse retire un personnage sans PdV du tableau des personnages (squad) et ajoute ce dernier au tableau des héros morts (deadSquadMembers).
    private func greatReaper(deadCharacter: Character) {
        
        self.deadSquadMembers.append(deadCharacter)
    }
    
    private func removeDeadPlayers() {
        self.squad.removeAll(where: { character in character.hp == 0
        })
}
}
