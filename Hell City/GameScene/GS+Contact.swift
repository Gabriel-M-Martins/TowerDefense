//
//  GS+Contact.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 18/06/24.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        let contactMask = bodyA.categoryBitMask | bodyB.categoryBitMask
        
        if contactMask == (PhysicsMasks.attackRange | PhysicsMasks.enemy) {
            guard let enemy = bodyA.node as? Enemy ?? bodyB.node as? Enemy else { return }
            guard let city = bodyA.node?.parent as? City ?? bodyB.node?.parent as? City else { return }
            
            enemy.startAttacking(city)
        }
    }
}
