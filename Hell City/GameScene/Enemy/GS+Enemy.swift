//
//  GS+Enemy.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 13/06/24.
//

import Foundation

extension GameScene: GSEnemy {
    internal func spawnEnemy(from camp: Camp) {
        let enemy = Enemy(settings: settings.enemy)
        enemy.position = camp.spawningPoint
        enemy.follow(path: camp.pathToCity)
        addChild(enemy)
    }
}

protocol GSEnemy: AnyObject {
    func spawnEnemy(from camp: Camp)
}
