//
//  GS+City.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func placeCity(at location: CGPoint, _ node: City?) -> Bool {
        guard let view else { return false }
        
        let outsideXBounds = location.x >= view.bounds.width*settings.map.scale || location.x <= -view.bounds.width*settings.map.scale
        let outsideYBounds = location.y >= view.bounds.height*settings.map.scale || location.y <= -view.bounds.height*settings.map.scale
        if outsideXBounds || outsideYBounds { return false }
        
        var node = node
        if node == nil {
            node = City()
        }
        
        inputState = .placing(.city(node))
        node?.position = location
        
        let isOverlappingNodes = !children.allSatisfy({ !$0.intersects(node!) })
        if !isOverlappingNodes {
            gameState = .inGame
            city = node
            
            let obstacles = SKNode.obstacles(fromNodeBounds: [node!])
            pathfindingGraph.addObstacles(obstacles)
            Animations.spawn(on: node!)
            addChild(node!)
            
            return true
        }
        
        return false
    }
}
