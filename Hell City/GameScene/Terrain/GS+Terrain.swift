//
//  GS+Terrain.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    internal func spawnTerrain(_ view: SKView) {
        var nodes: [SKNode] = []
        for _ in 0..<settings.terrain.quantity {
            let terrain: Terrain = Terrain()
            repeat {
                let x = CGFloat.random(in: -view.bounds.width*settings.map.scale...view.bounds.width*settings.map.scale)
                let y = CGFloat.random(in: -view.bounds.height*settings.map.scale...view.bounds.height*settings.map.scale)
                
                terrain.position = .init(x: x, y: y)
            } while !children.allSatisfy({ !$0.intersects(terrain) })
            
            nodes.append(terrain)
            addChild(terrain)
        }
        
        let obstacles = SKNode.obstacles(fromNodeBounds: nodes)
        pathfindingGraph.addObstacles(obstacles)
    }
}
