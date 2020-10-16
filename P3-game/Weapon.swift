//
//  Weapon.swift
//  P3-game
//
//  Created by Richardier on 27/07/2020.
//  Copyright © 2020 Ianis Richardier. All rights reserved.
//

import Foundation

class Weapon {
    var weaponType: String
    var damages: Int

    init(weaponType: String, damages: Int) {
        self.damages = damages
        self.weaponType = weaponType
    }

}
