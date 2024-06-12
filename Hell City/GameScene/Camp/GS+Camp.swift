//
//  GS+Camp.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func spawnCamp() {
        guard let view, let city else { return }
        
        let camp: Camp = Camp()
        repeat {
            let x = CGFloat.random(in: -view.bounds.width*settings.map.scale...view.bounds.width*settings.map.scale)
            let y = CGFloat.random(in: -view.bounds.height*settings.map.scale...view.bounds.height*settings.map.scale)
            
            camp.position = .init(x: x, y: y)
        } while !children.allSatisfy({ !$0.intersects(camp) })
        
        
        let obstacles = SKNode.obstacles(fromNodeBounds: [camp])
        if obstacles.isEmpty || obstacles.count > 1 { return }
        camp.obstacle = obstacles[0]
        camps.insert(camp)
        pathfindingGraph.addObstacles(obstacles)
        
        Animations.spawn(on: camp)
        addChild(camp)

        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self, let targetPoint = city.findValidSpawningPoint() else {
                self?.despawnCamp(camp)
                return
            }
            
            let hasValidPathToCity = camp.pathfind(to: targetPoint, on: pathfindingGraph)
            if !hasValidPathToCity { self.despawnCamp(camp) }
        }
    }
    
    internal func despawnCamp(_ camp: Camp) {
        DispatchQueue.main.async {
            Animations.despawn(on: camp)
            self.camps.remove(camp)
            guard let obstacle = camp.obstacle else { return }
            self.pathfindingGraph.removeObstacles([obstacle])
        }
    }
}
