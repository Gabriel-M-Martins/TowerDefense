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
//        let colors: [UIColor] = [.black, .brown, .cyan, .green]
//        for obstacle in pathfindingGraph.obstacles {
////            let path = CGMutablePath()
////            path.move(to: CGPoint(x: CGFloat(obstacle.vertex(at: 0).x), y: CGFloat(obstacle.vertex(at: 0).y)))
//            for i in 0..<obstacle.vertexCount {
//                let vertex = obstacle.vertex(at: i)
//                let f = SKShapeNode(circleOfRadius: 10)
//                f.fillColor = colors[i % colors.count]
//                f.position = .init(x: CGFloat(vertex.x), y: CGFloat(vertex.y))
//                addChild(f)
////                path.addLine(to: CGPoint(x: CGFloat(vertex.x), y: CGFloat(vertex.y)))
//            }
////            path.closeSubpath()
////            
////            let shape = SKShapeNode(path: path)
////            shape.strokeColor = .cyan
////            shape.lineWidth = 4.0
////            
////            addChild(shape)
//            
//        }
    }
}
