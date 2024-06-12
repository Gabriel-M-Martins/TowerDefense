//
//  Animations.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

enum Animations {
    static func spawn(on node: SKNode) {
        node.setScale(0)
        node.run(
            .sequence([
                .scale(to: 1.1, duration: 0.5),
                .scale(to: 1, duration: 0.15),
            ]),
            withKey: "spawn"
        )
    }
    
    static func despawn(on node: SKNode) {
        node.run(
            .sequence([
                .scale(to: 0, duration: 0.5),
                .removeFromParent()
            ])
        )
    }
}
