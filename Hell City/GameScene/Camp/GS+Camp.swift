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
        
        
        addChild(camp)
//        pathfindingGraph.addObstacles(SKNode.obstacles(fromNodeBounds: [camp]))

        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self, let targetPoint = city.findValidSpawningPoint() else {
                DispatchQueue.main.async {
                    Animations.despawn(on: camp)
                }
                return
            }
            
            let hasValidPathToCity = camp.pathfind(to: targetPoint, on: pathfindingGraph)
            if !hasValidPathToCity {
                DispatchQueue.main.async {
                    Animations.despawn(on: camp)
                }
                print("doesn't have path")
            }
        }
    }
}
